Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BC37D10A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162537; cv=none; b=bGr2rwI4Q+DWld0Kfj89XoMDcttE/IefQXfMoyPXJoelfh0CUubjUtO1uajUaivwLB3fELhpb+5X96VaK9Lf1q4DpPc52gmJKegiytBq/OWT2X1t2DbyiUhXhGy+ORNS9OUETTISEo/9iwt6g0Ye8/5y5UhLmT13q8qD4wQFrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162537; c=relaxed/simple;
	bh=1F2E0F8oWdzcK8owdnuCkCeBAUkTA6kxmehpUYOfQYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qahn2dG2hN7Naia0fLwIPFyk+N05kJ8xlin3qXnUT+/wweAKSzJ1KiQE/Sv4Y80AWCy1uRjvXbZm5R3twYq4BKJhEOeLeBXbPjmPNzIRuz2062i6nsME7K5bfUAgYcijvMJU/UvSrTqY5gYVG8TeQFzucCdg9rV1vwZvakm6kw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTQR4u7z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcVPLYe5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTQR4u7z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcVPLYe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785162533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgFmd6qXGD/1u/B/qklK0gxra4znkvRNbgLq4PG6yjo=;
	b=YTQR4u7zc0Q9kmugq1mbA2LxjrGmGAF8ok3stZKrLx0WvCONFA/jW15MwNM1j8upsvIX5U
	37KSfd9CJcWihWlOzh/NF93MycytW2PBTW1oy2ob2mkZMNuYx/GAR9q87Nq0fC9I5/6MIx
	AiAwTFUBduD2xxNm2t9s8vfq/LBIMwk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-05SX9AyNP4GihUb5pSNfeA-1; Mon, 27 Jul 2026 10:28:51 -0400
X-MC-Unique: 05SX9AyNP4GihUb5pSNfeA-1
X-Mimecast-MFC-AGG-ID: 05SX9AyNP4GihUb5pSNfeA_1785162530
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69afb1d30f5so4087829a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785162530; x=1785767330; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgFmd6qXGD/1u/B/qklK0gxra4znkvRNbgLq4PG6yjo=;
        b=LcVPLYe5T4gZ+qM03YZPW3uwZu4kay6mOYFhf9mDuUSAwieHUI1vfD6xs97UtxVexB
         Phtmrt7nltPi14CWKepGdX5YDZPdUWGgMxZleTR1j8hOjnLBf4KTeCG4uhTuFwccSvJj
         EM0GSIoFG5dyOmMPLaw+Zx7tU+rfHrJnLUgZ9spG43uKCq2mA1zjIU+JlNaSBc4nybdT
         6yRY2MS4XrzqJ/3IXPQTGd5Jn4RqWjQ4FH2p32lmXNd2Tj6KhEerK41dTTb7Z1k56SUx
         nAjpypPTejebcaFnyqitJbNi8rLx65WOMoa401bcUZLmdc8tosIcEcMe9lDYA7gyQz3i
         kciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162530; x=1785767330;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgFmd6qXGD/1u/B/qklK0gxra4znkvRNbgLq4PG6yjo=;
        b=QqUHLrT/aOH12EpeB+XFJKRl6iGpd5aBwHEbSlHiiyNPoZhGJU8LnvcqX24mPX71Bx
         yJ2ZqToda5BJvdQYDkH09DLmS/Zg3dltAt/Muts0f6NHPptmyRpRix5G7WDS0alxfpfq
         KwGs4l2O0QB17Vw6l+SiVwF4gw53uuMK59i28dMU2uugUD/waZU7EElu6YJ9ihpVdDF9
         M9BksUAxggl+8MjbuNGfE2+g0dmnEpI9taaQ/QYK6ngtsm+RHpF/Uk/rGkTxrFgs245i
         hH5P49nauHW7aiBG5FXp6kB3GVPPJQZZvrF1JiJ6YSK+t9qARklp4/oMz4tx6hsScOYr
         EMUA==
X-Gm-Message-State: AOJu0YywfWEnCrn/NQIjoJJKIV122+j3YnYUYOI2SOo8XYtcrqWVK0VA
	GD3MYyUgrgmnJzidhMifGnF1rTAKEeTxSY4+32IfLENUR5qvXJW0gC8GD0isJXuBlxN2OTUHIaX
	VwGC58hTjhhYAk2/ozhEL1MK/0jA1AJ/yjnOsOiMgddLlQX+TWhi6KTSLXQ==
X-Gm-Gg: AR+sD118rRvaglzDD5AXv8bupJg9tlDBSAFNhiHu+/YuCYv3u5WLxtNLtV9BpecQ6hu
	WtYMhL8b5Ei6FKfjyCnTSvyAxh24SZwT6Zi8g+FwIyF70KxcPr2138kYSgMSats02f4emsK9hNV
	eHthY72lwlsdiSMZ8spE0UzrC9+KMBxD3qCZGhjT2xVplsyn6y1/Qpgve8c67sj4PaauHTMWZP9
	TJEfi70Y6qigXaoa/rNaQJTryXo5oylcRF6DbRP5DL5nf+X6EZYJKMhnJkfStv5pG0dGwg0pZ+w
	Jq0lDQQX0VbeAxNlnVynIU1TXJhXaRmzts33Y7s22XephXLd7Zx5GebQgBFScz+rEysMM/1qhTV
	Oc9JKaParuM6YgYh4/Tn0UUMiRDlkWeXdqN1KsSBm2XNpLBBCaQ==
X-Received: by 2002:a05:6402:358b:b0:698:9450:92b0 with SMTP id 4fb4d7f45d1cf-69fc1007196mr3646742a12.1.1785162530114;
        Mon, 27 Jul 2026 07:28:50 -0700 (PDT)
X-Received: by 2002:a05:6402:358b:b0:698:9450:92b0 with SMTP id 4fb4d7f45d1cf-69fc1007196mr3646728a12.1.1785162529675;
        Mon, 27 Jul 2026 07:28:49 -0700 (PDT)
Received: from [10.44.33.167] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb50bd183sm2838839a12.4.2026.07.27.07.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:28:48 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tonghao Zhang <xiangxia.m.yue@gmail.com>,
 Aaron Conole <aconole@redhat.com>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: fix potential UAF on meter attach
 failure
Date: Mon, 27 Jul 2026 16:28:46 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <5EB5E9EA-2E4F-4226-993A-142C79A6DF00@redhat.com>
In-Reply-To: <20260727121022.198461-1-i.maximets@ovn.org>
References: <20260727121022.198461-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 27 Jul 2026, at 14:10, Ilya Maximets wrote:

> While attaching a newly created meter attach_meter() function makes
> the new meter visible to other CPUs but can still fail afterwards.
> On failure, it detaches the meter back and returns an error.
>
> However, this is an unexpected behavior for the ovs_meter_cmd_set()
> that uses a plain kfree(meter) on attach failure without waiting for
> RCU readers to stop using it, assuming it was never visible.
>
> This is never a problem for ovs-vswitchd as it always creates meters
> before creating any flows that use them.  But the UAF can be triggered
> with a custom application using uAPI:
>
>  BUG: KASAN: slab-use-after-free in ovs_meter_execute (net/openvswitch/meter.c:653)
>  Read of size 8 at addr ffff88810d152650 by task meter/2508
>
>  Call Trace:
>   ovs_meter_execute (net/openvswitch/meter.c:653)
>   do_execute_actions (net/openvswitch/actions.c:1407)
>   ovs_execute_actions (net/openvswitch/actions.c:1584)
>   ovs_packet_cmd_execute (net/openvswitch/datapath.c:703)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
>
>  Allocated by task 2519:
>   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
>   ovs_meter_cmd_set (net/openvswitch/meter.c:422)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
>
>  Freed by task 2519:
>   kfree (mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
>   ovs_meter_cmd_set (net/openvswitch/meter.c:479)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
>
> Fix that by making sure attach_meter() doesn't make the meter visible
> until all the checks are done and the function can't fail anymore.
>
> This also makes sure the "hash" value is calculated after the potential
> re-sizing of the table.
>
> Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-31642.
>
> Fixes: c7c4c44c9a95 ("net: openvswitch: expand the meters supported number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks, Ilya, for looking into this. The patch looks good to me.

Reviewed-by:  Eelco Chaudron <echaudro@redhat.com>

