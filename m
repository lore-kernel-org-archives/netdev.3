Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A667411F88
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801912; cv=none; b=XMGkiPjxqVlgFFMgw/c3q3SCMjPODku+LJJBS11miibiVUnQ+XTfx5iMUh5FTdxBBrU4yNJgRCv+9XHTvtB8sDioaJpPwiATZ/p0VyctcUiA5n4iwPlWGCa/Ym0QNaIkoqlWcXJeBA2eSDvQiECi/navrwk+aE+3Ltbr0dIGeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801912; c=relaxed/simple;
	bh=zkE1CxynhhuX45SZ6JJT+YmMZiFe1viNbE9YBLAS9Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PUCIMPlgUUIi48fvI7zfjA2LUqz1A4WRhPMIm2RLCbjCoSLYfFNlew6Y9UF2B5TjMeSkWDOKb3gWLuYp0Ie7Zk60h3sollVGDI7oQrH+iJZ6q0WNyLe0dnPAMBV4Jkr0JLmXUZcDct0tPVtNbOxrn7UsxYvrvEKyXqlG653wXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=By/GacvL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nyv8cTFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By/GacvL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nyv8cTFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784801910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
	b=By/GacvLSsvBat7gXEbrU4TErEaK6cK4Iz2JfTRlvINrC0FWMD54eWfuf+34gZEbXivfmk
	cIeK4tibE+x/eE9tca+QBypgE8428xheGSssa4jF2HgMyg0ytMRGWW5VRpTBHNaxsxErTA
	ZuzSr9jC8KaFuiiIYH29wLZDI9F/60A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-gr9djxlHOuabqRkbvbIPFQ-1; Thu, 23 Jul 2026 06:18:28 -0400
X-MC-Unique: gr9djxlHOuabqRkbvbIPFQ-1
X-Mimecast-MFC-AGG-ID: gr9djxlHOuabqRkbvbIPFQ_1784801908
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955d314945so3687825e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784801907; x=1785406707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
        b=Nyv8cTFq6wSkw9CFQGc+//PSIWnzoPn5H/e48wHEr3Pee2m2t8sfuEdKXoNR1f2HOG
         OYUzltGeNuGWsGLWewvuSYuRcH5RAkOvCn7Q4Ea/g/H8/Ge0SB1O+I31RfgT4KaYb3qb
         7A6cFWMJTiPiFF1vQDKuJ6kI7rVfIAB/kvfrou+vhW5OjQy3O8U9rr4BDr2bKvJjSwKr
         E238Co3rmqPohu54YH4nnW2gzQR5lDY3ysz5wmPFTVQPjhYIYgRZbN8gPJaJe27WzTKC
         I3N/TiNtHxa4yVzvhpHCoobLTVxNFkv1v56C671Ki/IxWFQWnHspCBM0hh9zY/mX78gH
         ficA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801907; x=1785406707;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
        b=CbQoRdHEjcZa/KB7WFXeAKNstw7do8+ohGVPeHqGfrkVZxVDlC6B/pbWpipyEIyzCh
         6SOoJ2D6not47/1dQItcJAfyXcXe8w4mSrcpKnkjBLXBoxJOC5soCo+RsfmsV2KY+nWm
         s1mVfwJPQTrJ23W9jrg90lAyTGRFVtPGcDIcZE+iWZ79e5rdfbQTVFHGhXIUhC4G91+P
         CVeDV7Cu8qgW4eYkEmoffjKlqSX5g9DSVu4sbz8fcJ1X0zyLO/VWoAWhUdzKVNsKXOce
         DS4MF5JOmAf2F9x1GCTtRToqcW/ivegNrGG8UovfE0PhPxwcEL83Iw5cJ59gN2q+rAE4
         q/DA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8rce9tdRfCvEvAmlf/66FER+VDWNYQb/XUERQH8GeKOQl3wzWdCCbdggVTVBp8WsyvpBkJrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQuxr2us7owy+32CL83sBoJgYldpC1mgwhPoRegMuhXAokArm
	J7Ge4TW1kD3qwVgfL3O/e85k2dQrrSmk0+hjR+iqT/L2hUozFeP6pH2a6DuHrEYyhGrmMNqXKxd
	+lcric5r9r2YYyJdb0UmV8TebM3O3gNjTgIVoDIR2MNsDO7sEep6sMd42bg==
X-Gm-Gg: AR+sD10CeY/TDDYJMO3xJZslPePllvLpE236KnzW2qw9Jp8yU4AmXXgVqV6hkU/WLxV
	LsF8j8YBNeNncBFi1JwwAgdLA9JSG19Zxvgz91S2l8knRELaA7O56S7QIL9EOTYvEt9HwSxGCzD
	JbV5ivIK+ZBpTJjvYxbkbfhFCOYP09u7F04HGm8+gpV0PO6DAu9uduX56mZ3Qig1/l1pagU8f9s
	VO/OEd6x+dGJlW6kWG1OhrqVogufcDWwGbb9xKFdUE9/OhCTJuFYAV2nX98jbGqCglDet+mDBLU
	CNHoxIinfNMNDs/ZSJIskJVa4GtWkgt/7Q4RjnKv9t2hHSgtiUEkunw2lGcm2CZEsjthTOWZPnp
	Qm/rv6XRjhnf/PZkYumn/yCxV11uOc5b/mktJv0KuI7tH+8lQCpfyYnhNx1PtWTu3sRhAQ6Db3k
	META==
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr25163665e9.36.1784801907414;
        Thu, 23 Jul 2026 03:18:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr25163275e9.36.1784801906974;
        Thu, 23 Jul 2026 03:18:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm218761215e9.10.2026.07.23.03.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:18:26 -0700 (PDT)
Message-ID: <d2014044-d410-466a-ae66-2a173dbdba82@redhat.com>
Date: Thu, 23 Jul 2026 12:18:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 4/4] net: mana: recover port on attach
 failure in ethtool operations
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com,
 schakrabarti@linux.microsoft.com, gargaditya@linux.microsoft.com
References: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
 <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 6:10 AM, Dipayaan Roy wrote:
> When mana_attach() fails during ethtool ring size or channel count
> changes, the port is left in a broken state with no recovery
> mechanism, requiring manual intervention to bring the port back up.
> 
> On VM SKUs without a netvsc fallback interface, this results in
> complete loss of network connectivity to the VM.
> 
> Fix by scheduling queue_reset_work when mana_attach() fails. The
> preceding patch ensures mana_detach() always completes its full
> teardown (netif_device_detach + cleanup), so the reset handler's
> mana_detach() takes the "already detached" early return, preserving
> port_st_save for a successful mana_attach() recovery.
> 
> When mana_attach() fails, choose retry values that maximize recovery
> chances: if the operation was an increase, fall back to the previous
> working values; if it was a decrease but still above default, fall
> back to defaults; otherwise use the minimum supported values.
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Tested-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
sashiko gemini sees quite a bit of problem with the above approach:

https://sashiko.dev/#/patchset/20260711041415.3008868-1-dipayanroy%40linux.microsoft.com

Also, changing user-setting in case of fallback is quite a bad thing to
be avoided.

Skimming over the code, it looks like than pre-allocate all the
resources and to a replace instead of detach/attach() looks feasible. I
suggest investigating such path. I also think that this last patch (and
possibly 2/4) could/should be in separate series.

Finally and most relevant thing; AI review comments should be explicitly
acknowledged by either debating them or addressing them. In both cases a
reply on the ML is expected.

/P

