Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C67466B57
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037423; cv=none; b=N2gSK1O4YP7SCFrz1Mw36jEWLY96L5fcRNOT+tWejKXjys5Jwnj9olHO6GJ3G1aVwqGs43//CeuCGII1hTJv+s9pWg+HR8VJeZW15IeHsp0wLhWdIKJWeHMpgUch0fdTH1+XrTnU4N0CliepnmxQUiLlhL/rtyXW3xPz6h8lqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037423; c=relaxed/simple;
	bh=lrIXAC8cYNoVygFDFSiOCaWQyot7ZJ6zRghfRlFdzz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RY6lwhmy5MwLSY382lxUVv+l/9bPW/Ri5KDqAVBcSmypzOz6n3UbtEc6uC2eK4J57txlVs6zbj1soi+70xuXf6CFIzDwTW7PSBluOYgYq5gFmqJxigNDp5cqVt0kxkL1WYT9+Zj/eZXGMs7LrZuC6vw0G1oLbn4Ka2w2bGOKMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6Do+ZFb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJlqgjN8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Do+ZFb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJlqgjN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789037414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7hkRUQ+GXdK6lyDfi0TTOprM8ecwt5B1P/G3pNJiII=;
	b=b6Do+ZFbW6dLY9UI+m/ljJKlGCb9VxBuUMtM0QsYd6BOipTH3CMMSIi6mWwJxLUzZCGT7t
	vn2eFnEkQ4RDfjRGusbnSccLVxXffV8P2MRbcRG/7PnI2FJT1fLTPuArNPCqNbPmBgii0T
	Sp86xvmMk3zAlXQIbw+xa2uwsn4daFg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-3Le7ajiuO_GW7PEckNPaNQ-1; Thu, 10 Sep 2026 06:50:13 -0400
X-MC-Unique: 3Le7ajiuO_GW7PEckNPaNQ-1
X-Mimecast-MFC-AGG-ID: 3Le7ajiuO_GW7PEckNPaNQ_1789037412
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so101908595e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789037412; x=1789642212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7hkRUQ+GXdK6lyDfi0TTOprM8ecwt5B1P/G3pNJiII=;
        b=FJlqgjN8fNyj5sUYVLFPkFRJG6Y0kKHLxxFnbt2KmfRizK09cozWMJv9g7/1liRo/S
         lnTipB7cSn/g28p8+6yKRv/uZUAGDJNCN3KDsxTKKWlR5ybpQ8eo0tibXN1pIvrpjEAz
         hoo2f41QeVz6Z38mgd7b3C12uhs6Ikvz+GurbGPxy15kNd0jAZKjsfoBcNFk98Tb/VWn
         LaiEGKtGhB7hZg4ZR63BvHCdP53QM6k1fKGCiTl3unNtxbxPh1eHQCmWeVpQzvhaiq1h
         q6KcKWOBvxTk+0B9xc4jGlQ2zipM5RTy0Wo7k8XD6k1ljlreBJjvxz0/dkAuvcgnI7ZW
         8VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037412; x=1789642212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t7hkRUQ+GXdK6lyDfi0TTOprM8ecwt5B1P/G3pNJiII=;
        b=Bzr2fITBBT/iELqur7bGhIrb2Y/W/wcp51M2ZBXDl6YMAM0vJ11AZt5cScm/FaYJef
         aUyPB+6i6JbHYOOuUeE2Bh112LDiNrZpdvmz7H+FTxFYkGKsXaUDoeysVWgRqkt5n0R7
         ITcMeGMFux6WGcI+wUaViP7XivTvK9B+A3Yrj/GOrDHwhrprDvmn2Ka6V//y+KzbAjGY
         Vb/QSzTVEi9sk0/ovSa/74CkvyWPsinJDDHvBUC2p7VCri1egNR8uKL0lNZicZPi8yvM
         k2oN/OZGqj6KuRSlpABKO0TG0crqP5WjmACd235ngijhcwYmL5X51Sgxhndg7wtdF9VZ
         mg7A==
X-Forwarded-Encrypted: i=1; AKwUvBzu4ISDchh7bxg7zSCNowfkOOJFraspHoa4VLnPpRI9w5WpDIBPFziXv/Aom8STYb+5BKZB/cc=@vger.kernel.org
X-Gm-Message-State: AFuF++ln+UitxRuzSqUuRL+RZWhWk3tTuzIG1XLhA4cknFcD8bI6Nje7
	AnZiLwoed91H520vX6DUEkQTet+XPc8Cez3jEMVfM3ZWuf5U7ImtRVZQSG9vFL4veMvIdK0aQib
	jNLIUl6gdTESsU8ESxdrA7aSDBq9BjE9M5CvDk6Oko1anM5ougs3XNEBAHw==
X-Gm-Gg: AYBFou3INDdEaFALCkUZc5keQF2LEBJquwdSB0BC5yH4Xok3WhK+esYrccwUwCULJq6
	a19Y5KeiJHMKLS98DW7Nh03r3IaCHbMNt+NU5QXlGs9DaERR5U0Ak+Eayxvg4GNQaOrre4fjK/Q
	3LWhxfxhOyzzuHVmdpYQRC4+eUEbm7ThcjyM/iatOYCAjUNXK/qMyQkE6k6rDAWefXjpylKMtIg
	cTKMGi9mPbUV6HBvfDbxbI5a70byeO0FFMrYJrR4XttyFVcCHS1IcnqOvscnzuoE0PXXip1mzEM
	ynMLGXcK1Y6ACBMopyJqk01ARbEHx+B5wYHr0znzBMpvbjleXU85nGlmbQBtj3wKtpcGXY/b+VS
	A4m2ExdfYfAOJGgwMLPFlatHbd2Ohq9lmlse12lOVUs10Qm60CzSLiyjaPALWpueaNkwcIwTCLg
	==
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr490158015e9.12.1789037412228;
        Thu, 10 Sep 2026 03:50:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr490157565e9.12.1789037411810;
        Thu, 10 Sep 2026 03:50:11 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfc1sm81538805e9.4.2026.09.10.03.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:50:11 -0700 (PDT)
Message-ID: <ebded824-c858-4187-948c-b5444f4bf82c@redhat.com>
Date: Thu, 10 Sep 2026 12:50:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix abort_work termination in
 smc_conn_free()
To: Hidayath Khan <hidayath@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260907114721.1303498-1-hidayath@linux.ibm.com>
 <20260908114743.481841F00A3A@smtp.kernel.org>
 <3991782b-7a63-4bc9-94c2-02b3f9173586@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3991782b-7a63-4bc9-94c2-02b3f9173586@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 8:48 AM, Hidayath Khan wrote:
> 
> On 08/09/26 5:17 pm, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [Critical] Late-queued `tx_work` can execute on a freed socket because it does not hold a socket reference, causing a use-after-free.
>> --
> Thanks for the Sashiko AI review. The finding is correct.
> 
> tx_work is the only one of the three connection work items with no socket
> reference:
> 
>    close_work   sock_hold smc_cdc.c:420   sock_put smc_close.c:444
>    abort_work   sock_hold smc_cdc.c:324   sock_put smc_core.c:1754
>    tx_work        none                                  none
> 
> The link group holds a reference while the connection is registered, which
> is what hides this. smc_conn_free() drops it in smc_lgr_unregister_conn()
> and never cancels tx_work - it only cancels abort_work - and the link
> group usually outlives the socket, so lgr->tx_wq is still there to run an
> item that was queued late.
> 
> Worth noting the fix in this patch does not transfer. conn->freed works
> for abort_work because abort_work holds a reference, so the socket is
> alive and the flag is safe to read. tx_work holds nothing, so by the time
> it runs there may be no conn to test. It needs the missing reference
> rather than a guard: sock_hold() at the three queue sites, sock_put() in
> smc_tx_work(), and the reference returned at the cancel sites that report
> they removed a pending item.
> 
> I will send that separately, since it is a different work item and a
> different fix. This patch is unchanged.
Could you please have a look at clashiko report, too? that looks
correct, too and more strictly tied to the issue addressed here.

Also note that netdev-wise the most relevant sashiko instance is
the nipa/clashiko one, as it includes reports/reviews/findings
from the public clashiko instance.

/P

