Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FB1E7C02
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427533; cv=none; b=Em/REafNE+GpmylMFOiY7FjFlfKrKB/mxJTSPNN1kHAeiZD2uWYaZ0OvqI76Rfy4uWAwlhlgU762S0sUU4NGUHloNepBKfZ3M+JHyT6CLTZ1tYQhZztN9jJHShazaIQB86dY11stKrmHozMkTnbaSUAtVbTu34MYAw5NADquhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427533; c=relaxed/simple;
	bh=F3bEffyo0R4/edNFXtIcXkcvoM1A7JYlTzpbbIagYxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa+YBzcwKhqInE2x7ucx0DF8FS37jYXGJXhC4uNM+IynZsC9PlxRFEy5W/e+yNLP0NfS6TXravviZjJM+Jkiuxsg0uzaF0h38EVMqJ4Wt5WIpeHZ2P+vWgKFwA2KxE+w3Qevvn2OgKfgasuZgK+wdODOiYpn4EsaPs1mVUU/+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkiwP+7v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpKNapWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkiwP+7v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpKNapWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PKW0eXtHxdKlv3YbhDeBo6WYo0CMN3NwYmrHCs4Z7w=;
	b=GkiwP+7vka45x8gjWwDvNE6qtwWS/EPWETnNpbBUKa31uNhv6f1w1yHqoxFk+yNfaF+Y3d
	2KlVE6NDUgvyBsfyAve8aOxIYljx/zI26I8JLShtt4G4Ivl6c+m2KVixqxDJVW/U7dWJEB
	R5NeWPCjcnyodpmHyZVZaRj7rHrHf3o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-4-g8cOLpMw2gVMWI-vf9Uw-1; Thu, 03 Sep 2026 05:25:26 -0400
X-MC-Unique: 4-g8cOLpMw2gVMWI-vf9Uw-1
X-Mimecast-MFC-AGG-ID: 4-g8cOLpMw2gVMWI-vf9Uw_1788427525
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-485835753caso283434f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788427525; x=1789032325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PKW0eXtHxdKlv3YbhDeBo6WYo0CMN3NwYmrHCs4Z7w=;
        b=RpKNapWZZpYD31waRw7sGdGDQOnHzECy8mm/yfByJfQwbK2H8p3ocGIv9m+13W7NiY
         zgJxCBK53kfLzCkQOSAcmB2q/OlXnB2aXcdhJke+G6NSSEnP8ZdYzoeFnXEeGJRoEHUX
         2E3ZNc2ErUNi8CWm2n3ero3YI2nQlIS4Gcdh2gWYOf77hXk6ouJgbQpnq2WwwSGbijIH
         F96YisWaAJfflY7dEwFGNYhUDaHTPn5J1h/UJfaFwE6cq6BhapLYzLS0MUnlQCxSm0/9
         GG2s1nVyLZLEq1oPTsrv5NuU3ZZ5R3nOsn1w3McY4YunsK3xF4zwCfw8DzCjCFChEzjR
         I9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427525; x=1789032325;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PKW0eXtHxdKlv3YbhDeBo6WYo0CMN3NwYmrHCs4Z7w=;
        b=hpvezzhxzVjKJQbMrTPDS98/4+RNfsX2ywpdkiEOEzK8riwnp0fg1ExgDfFLVVrYav
         ER1ndMNBqVbd9DuZC1x+m/fzLT0NFzn7pLrQxXbPwGFA1NANmuqzXkrVviltLSMCxLHX
         thAcZoohS2jobO9mY3IzZuryZMP8yH8xqoM39HrYBdAvlWMDUCEe568D5H/w+Gapv88p
         8JTFL3xX0SK4OtR8jMEprZHZDUjnrrNG61umCS4Icet/QDjWu8TDbGc3QOiRliUD6M8F
         hOfthdeLy+ZMyELJ6+l2xj8HTwRP102elYjysCC3yFLv4LyKr6I5zVwnFbL7/VmkLV5h
         9NGQ==
X-Gm-Message-State: AFuF++mcSS/0EnZ5XS0MmZ0B44mhxkt0pqd+B4GrfnHwbGvvu+mzpx8a
	2R7TyGNIwrIMJMam7lJJ/Z6AcddB8kIAkZyyz4cGdIMGavCXhjleYmuFKxhYs2BaTvj94QhQgOj
	i3+UXbgSjIBMbsmBSDnZInPCL22Kr0HyMTRc2ZKNUllef1M4HnkNP2uYV0w==
X-Gm-Gg: AYBFou3WO8yFMX1iPzvN0OKpjqZVvDw6oc/ZOUpIofN/92Kd7k8S98vpTJ7RwNOK3iS
	egKj41MykHGn8otpgdr3A/bIV7cB2qFeGEPeZbXkKdPLubblllWMrGSEPePo9CKuoLH7UWveWzX
	pKa3wwimsseAYQMc5GMPxwl3tfd8s3yoZqNBm/MY4SYDSdWQdqOm/SKmx+t4I0IQzfuzpcfOwUS
	TSbeFgxho6Tz3AT1F2y/bTjI8QYpuTMHjy5QJc/r6FPofmhR18SMgm80N0ZMODnM2ixbyOGpktH
	+LLmh/9en5vupF1FDsV/YY6IEE7p19bYqDvbjKDj/l2tStJRx92Xgx4UlBZVLnjK+6GUmNJkrLa
	kI0lDwMe7Ala0lRETn1Tq9dkANi8iNUK+LUJB5uX+HpYDw3GFg/ltGTaae+Okr4ciwdyycee5tQ
	==
X-Received: by 2002:a05:6000:490e:b0:484:478e:e19f with SMTP id ffacd0b85a97d-4847b6266a6mr21200364f8f.0.1788427524973;
        Thu, 03 Sep 2026 02:25:24 -0700 (PDT)
X-Received: by 2002:a05:6000:490e:b0:484:478e:e19f with SMTP id ffacd0b85a97d-4847b6266a6mr21200258f8f.0.1788427524490;
        Thu, 03 Sep 2026 02:25:24 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm12823430f8f.27.2026.09.03.02.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:25:23 -0700 (PDT)
Message-ID: <fe767fdb-634f-44d4-9a4e-80b2f8c5647f@redhat.com>
Date: Thu, 3 Sep 2026 11:25:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v23,02/14] virtio_pci: Fix sleeping under spinlock in
 admin command path
To: netdev-bot+sashiko@kernel.org, shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
References: <20260831161109.2999926-3-shshitrit@nvidia.com>
 <178835473723.3394541.8002424749068111766@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178835473723.3394541.8002424749068111766@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 3:12 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 (2) · Medium: 2 · Low: 1
> 
> - [High] The patch adds a new `vp_dev->admin_vq.info = NULL` store in
>   vp_del_vq() (drivers/virtio/virtio_pci_common.c:261) but does not…

At least this one looks real and worth addressing to me.

/P

