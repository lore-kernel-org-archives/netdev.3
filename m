Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A824A92CB
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649470; cv=none; b=PIR/Pf3w4KodQaX1TdAVO2QEU48/DILXxctyk4ext5TkZGHfDHLyWXfYeno+IqfNsQDDVaD9AgNOTfDa4+/Hm89REj6z4ezpQ8uxoKNjk9357mKTeh7f00s73iQ2A1d6C2kFKLgMllLx8XpYC2nGTuQY5znRtXqEbb4Zgdb/nmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649470; c=relaxed/simple;
	bh=tLzXCoeBXWMBLdf4hcqdE7UwmQzpd9j5Qxatygixx3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3IYDdzCXgZfs8nteWp4lPYazypTYI+XWs7ZIGSLE8onmgnfKkT8CF3f4APvWsj1E3dXlh5pcZzA7KdSdSa+GI7nuwX7hbmxfBhqxpD7KJVvJz9F66MmovP+shJb55VqPBTymrJ9A/xK+lIf6H5NBWy+mniNANncB06kMLLMwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNkzqsPg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImPP5ey6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNkzqsPg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImPP5ey6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789649456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ/pN4UH8PsbqrtaniySTTfv1/s/vKEHugee7dSCF4Q=;
	b=gNkzqsPgL19hCXy9TzBlwq2sbRtLcYi0HIRX3ybFygWv5r1rPJSy/THqMlL/Bd/UjzDbi4
	OlfMkDGjQd30HgOjjBh2CwJDVcdZaMhuL2dDaQbG4MnYPN7tN/HPiwhUCVCDDFAq1jrYQz
	PGZF2pRqe1AB53kT3JRTPEv13ZosUWo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-1X2Td-JjPtChkH_vU-3O0g-1; Thu, 17 Sep 2026 08:50:55 -0400
X-MC-Unique: 1X2Td-JjPtChkH_vU-3O0g-1
X-Mimecast-MFC-AGG-ID: 1X2Td-JjPtChkH_vU-3O0g_1789649454
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4870af30a85so476411f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789649454; x=1790254254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LJ/pN4UH8PsbqrtaniySTTfv1/s/vKEHugee7dSCF4Q=;
        b=ImPP5ey6fKLI2tt3DU/ECmlBNuHsRuymKH9px5UV4tMgr/gLopZ2OlQm5I6YxsLeSq
         IJMV3PYGngwBSlVeuFVzpgDAAb/kgaC8BfzqpQMs2rKQUJKJFSOnEDxgUO49NM81nPJC
         PFBWuUUT8i8xP6yNeHD6kFdNwgdBQm1DAQnFqoNLLHQKYkjMQpPP+MauF0njfWRmVLYq
         O/o/rcRE2W2Q4zGVkYj6X5amN/W5KrpxK1J0mVEN8IDg1rRUZ8vLml0Px1+Js//3BOpK
         8+yb2UD4MO2EpTfVtu8Ats5J12L8Z8qbRfBT2ApX4dL8KKylmaR+TDyXkaEZrmN5Va7D
         FFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649454; x=1790254254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJ/pN4UH8PsbqrtaniySTTfv1/s/vKEHugee7dSCF4Q=;
        b=rifB0934MP9DQISln3hCZcdAjQM1enmAqfnTUICuSO32CrxE2O71eRkZwu8kNgESLl
         PXZsZQzlgFYA6zmAHxDgP2x14fxJaC99jDfr9O8RjBQ2dRSSm7NT7K/Jh0kw3vZaVslo
         HIl7HhOC5wY87PGBQ3QAX1gjgiOUJG/LbcVKk3ahzihCR7aYPlDIdYSzfGOiGMTbcmrM
         Aad349Yb4LGUlLVFL96FSQdGJ3CQMERrMnLu/elg/ji0myijoe1bokuIhHjlW2o3mYYs
         Jx++polr56xAIFX3SaFaNMdgi09T2/XB+mOXqeqPAMi+r1CT5sw2c8BmkD7QfZA1fcdP
         4tLg==
X-Gm-Message-State: AFuF++lr8DRFJkZFgIi00XDejfkpxx5o/T8dGE98rGedcsQQjGbN5PIF
	kHe5/Wzs+kfzA5rlGXne6SyRmCW1+EJrNHVv18j1KJ/rKHSWFmuiP/nL9iaccBnTMwez6Cv2fEE
	41rhSJQNvNu3Q13O45ZAzXi0zwdlaK68jMsPilAsBCsDp9n2j0Ta0URnyjQ==
X-Gm-Gg: AYBFou1W1wU+oarr1NPqEMO6w5vNvRaF2P66siAdvyOsFDeinmDBgWO3jMWRKYtDPn7
	aGK68e4ObmguK61WV1io7V9Vwjb0rp0nUvCYzwa3hbnXUM+XyT6ezUhfH6WeKVLLxjPfC0efnRR
	fdEqHYpCtRinarL3sSL9eWpWcBrvnRx3SkxYFI2YxsbkAHihP2DWog8rvRlX0/4fC6YVcdKtUMI
	6Pt2el6gxEiY5hhfTvGFMkAV4WcGesPvldoWTcoAQt4m2KOnSzUN52vZA42OExA7TFtZZetjg4e
	ql6Kcvw9fgOoFfsSXI78X6ODneTv/kQIIFcFtuxIXMeXc/TN7FV7da3Zp3/jxbajSQp86YUutag
	TDNxOB3YWmbcx8Mg6EXihU5qff7AbRQZU7Rqid2iwkC5GYYb5QMQIgu56dK+TZvn3/pk9FCP69A
	==
X-Received: by 2002:a05:6000:41ce:b0:487:462:d85d with SMTP id ffacd0b85a97d-48713c47239mr4719330f8f.18.1789649454006;
        Thu, 17 Sep 2026 05:50:54 -0700 (PDT)
X-Received: by 2002:a05:6000:41ce:b0:487:462:d85d with SMTP id ffacd0b85a97d-48713c47239mr4719295f8f.18.1789649453636;
        Thu, 17 Sep 2026 05:50:53 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm15442868f8f.20.2026.09.17.05.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:50:52 -0700 (PDT)
Message-ID: <c6a9e7ce-3f23-4faa-ad5b-1ec77154b4ac@redhat.com>
Date: Thu, 17 Sep 2026 14:50:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: reject a reference sync pin which is not on the
 pin's dpll
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, ivecera@redhat.com, milena.olech@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260915213047.1352286-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260915213047.1352286-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 23:30, Jakub Kicinski wrote:
> dpll_pin_ref_sync_state_set() resolves the partner's driver private data
> with dpll_pin_on_dpll_priv() and passes the result to ref_sync_get() and
> ref_sync_set() without looking at it. The helper returns NULL when the
> partner holds no ref on that dpll. Of the two drivers implementing the
> feature only zl3073x dereferences the pointer (sync_pin->id); ice ignores
> it, so ice cannot fault here.
> 
> The NULL is a teardown race, not a steady state - zl3073x registers every
> input pin with every channel, so the partner is normally present on the
> dpll the base pin resolves to. zl3073x_dev_stop() unregisters pins one at
> a time, taking and dropping dpll_lock for each, and between the partner's
> turn and the base pin's the partner is out of that dpll's pin_refs while
> still registered with the channels not yet torn down, so
> dpll_pin_available() keeps passing. That path is not only driver removal:
> devlink reload and devlink dev flash both run zl3073x_dev_stop().
> 
> Reproduced by holding that state open with a mock dpll device, which is
> where the frame name comes from:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:mock_ref_sync_get+0x5/0x30
>   Call Trace:
>    <TASK>
>    dpll_pin_ref_sync_set+0x19f/0x4a0
>    dpll_nl_pin_set_doit+0x17d/0x840
>    genl_family_rcv_msg_doit+0xd6/0x130
>    genl_rcv_msg+0x181/0x2b0
>    netlink_rcv_skb+0x55/0x100
>    genl_rcv+0x23/0x30
>    netlink_unicast+0x24d/0x370
>    netlink_sendmsg+0x1e2/0x420
>    __sys_sendto+0x1db/0x1f0
>    __x64_sys_sendto+0x1f/0x30
>    do_syscall_64+0xe1/0x490
> 
> Commit d2e914a4a0d0 ("dpll: fix NULL pointer dereference in
> dpll_msg_add_pin_ref_sync()") added the same guard to the read side, which
> the kernel walks into by itself because the delete notification is emitted
> from inside the unregister; the write side needs a pin-set to land in the
> window and was left alone. Test the priv rather than look up pin_refs
> directly, so that the two halves key off the same condition.
> 
> Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Note that sashiko suggests more follow-up:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915213047.1352286-1-kuba@kernel.org

/P

