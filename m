Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388383AF662
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091504; cv=none; b=TVheqdhPMCyYdBHjUK1beBJouD7RkbVQ7y0Ro6yj84YQKLZEv9NfrIcAaqauqUyz19fAquAEWd8aFRCztRCfbjknWoV7OICWySNnJ1DMkB0v/6cXSSyWiK2zIiGCXz4QRSTgTb64whE0Rqp8Gv8/oz8rbrlMqzIWhluYKiiw6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091504; c=relaxed/simple;
	bh=BAQw95zm7I4QyIEk3qphNJd8baZeUD/GvCDwvrwd1nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnfrNTw04PjaDwB9yeUErzMAL0ZGz+61Em8zp8dj3flbg9F1pFy1ZxGgRg/RfbuuG7riGb4/OHTo+zG8SxUBxwN2i8i6RstXD/bp6iX8J5oWII6Rnnh83yNMVfFVbArqem2+IqjALS0H6Ur0TLU6uMU+qXK4nXPm1oIFL7bPwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CB/pSn4Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFRYKwZe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB/pSn4Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFRYKwZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786091494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWZ7ebWd0/tPXvvw5j8PF/AV+Q2MSNIx2DQCKuNhQbw=;
	b=CB/pSn4Qll9UF4lPLc+dMvBlOR0j+Iz8FrTlUN/jrXJBiekjrGlkXYqcQcPnGbpK642qU/
	Q1Qi6QQe62s3QiNFMNgPvVhoKIOu3AjqSZsMkd2VktIKQkHCxI9jA2BU+vSkVxZZ7F77Ng
	QYzUwwemNwDhSg1Wqn6kfrCOPV9oXOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-i3bYub1DPDKOH5ZtvWrTeA-1; Fri, 07 Aug 2026 04:31:32 -0400
X-MC-Unique: i3bYub1DPDKOH5ZtvWrTeA-1
X-Mimecast-MFC-AGG-ID: i3bYub1DPDKOH5ZtvWrTeA_1786091491
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f90dbaf84so2320465f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786091491; x=1786696291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWZ7ebWd0/tPXvvw5j8PF/AV+Q2MSNIx2DQCKuNhQbw=;
        b=NFRYKwZeajbOYF8QsMxZIYr2I1Ql+TKBY5WH2/5MHl+R4ClfPX2r7rpesZPnd/epbp
         r3VDAcqIISqaJa1aC37SdWPYLChRYraPKQWqfB0dTZNWBXm5kq8WZAIBtecaWmfsdXHl
         T/x9AWl70BAoiy4IgN9FBP0bcY9NWpYtw1XiKIVtHEAwvQaqEyGbUgRDYmtC2NFbP7sl
         v+sVj4gDbiyC2qG5us38JptgWRVD+LykqQeQzK7pIFvPIOtf61o28ompWPSOEI4vQv2x
         jfbpbpYtOj9qA8pv+bOADRcr/x0x//NEmYDYl5EKuNlV9Jz+M8nV8XW2ixSLg1b1BCKm
         QUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091491; x=1786696291;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWZ7ebWd0/tPXvvw5j8PF/AV+Q2MSNIx2DQCKuNhQbw=;
        b=Tabm6vvpC0H7nL1xGhBfq4JlYLtOH+hab8+WYdw83uu7aih+z55ZPe+X9cefCD6x5I
         QJZsFTmdI7f0alFkghvzM9qXvLpTVYplmr/murX2a0FK5Cn+Jl+UCQ6S7yz5bC8w1sGi
         go51gnke6H5ua4SUDEPDOWbNLVJWvofcpAyOR5i7pCekxKbgLw8qtdYSPB2hZ7Bp+Vbj
         o6xQAf1jVnussKyCw0hlnlwnqmUmAAxM1S170dr00cwiliutEAJrFcIX98/VkPolT7Ms
         pdkFAkWbbhnX6YiaF58CF83YnYzqoRhBDNHrsAHT+b8jT8t/BV6M9rUMlBkOuUMsQJki
         OhIA==
X-Forwarded-Encrypted: i=1; AHgh+RoWwFw+umhd0YKhH0MUu8+SBNgNAEP+2QLzl8ejC1jp8oT4CelB1pSp65Agf2Ohb4RBf6Lg3Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GuMVl/OQP4T3gSEwoaZd1sQKnTqH04w6riBIYGr94wulPLsl
	K7r7uaIGZRTlFlIkGDGKejG5Oc84zYj6ecosvRNmdfNcYqeKbKf4bvMQ6CQ+wWG6Bx8vbg7QUfG
	RQ3uRyTgNpEKMi5SptCE4ynJxGP7CuMhtaahPPDUfBNq5I8tgGYBSit12kA==
X-Gm-Gg: AR+sD1169w1/FsCR2TRM8F3gl8OMR+nMkuj369kHk4HIVi4ZICF+9cQBbgKOjmVt8un
	0ZFGJfuhprn2706NNfqUB7psb1eFhB5gjjVhRkvo/Bu51/UTinnD+BHHcsBOBjo9J/5wTswgIAm
	bKzm5EU6e183HSU0DCZOIbiS+D/okKpnO4H1yjeU/6lhV56p8/Hr40a/nFPdIXgqMcioufFXWNU
	EFUV/ZVrwOzew5BJdWOu6rKIMpPx5qFVNw1dy879WDxpPvNsHAusgXrwBBVvhjmKqLAvKzVoMB6
	vtFGk1nptRPKxnN3oNi8snu6lslx2kFDKC7xgC4/rex4Bmvh5FBWh+FK1S3GarwCEunI3H5BPXM
	MRQ1ig9doL6OKcUN4Ob/azRZe0LEFocJlVtC5AwcilB+xXaOJ9Cpg6KS3dQ0E3e+ThtmJX9jA64
	s=
X-Received: by 2002:a05:6000:41d3:b0:47f:f20c:e8a4 with SMTP id ffacd0b85a97d-47ff20cea51mr27353634f8f.19.1786091491430;
        Fri, 07 Aug 2026 01:31:31 -0700 (PDT)
X-Received: by 2002:a05:6000:41d3:b0:47f:f20c:e8a4 with SMTP id ffacd0b85a97d-47ff20cea51mr27353524f8f.19.1786091490938;
        Fri, 07 Aug 2026 01:31:30 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm4098371f8f.18.2026.08.07.01.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 01:31:30 -0700 (PDT)
Message-ID: <4dfd3009-efa3-4cc8-9d67-a9e845fa2d1c@redhat.com>
Date: Fri, 7 Aug 2026 10:31:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
To: Ido Schimmel <idosch@nvidia.com>
Cc: zhilin zou <zhilinz@nebusec.ai>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, tom@herbertland.com, vega@nebusec.ai
References: <cover.1785734738.git.zhilinz@nebusec.ai>
 <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
 <20260805090721.GA1364862@shredder> <20260805172902.27c9bde0@kernel.org>
 <20260806085214.GA1748060@shredder>
 <CANB6i5xN-rrcVe9foAJ+nUP-6VLrgXa90kwh5banCUVDOwG=1A@mail.gmail.com>
 <ae905b11-1b13-4f3e-8705-8a8c2ea7f54b@redhat.com>
 <20260806181918.GA2060872@shredder>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260806181918.GA2060872@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/6/26 8:19 PM, Ido Schimmel wrote:
> On Thu, Aug 06, 2026 at 06:28:00PM +0200, Paolo Abeni wrote:
>> On 8/6/26 11:06 AM, zhilin zou wrote:
>>> On Thu, Aug 6, 2026 at 4:52 PM Ido Schimmel <idosch@nvidia.com> wrote:
>>>>
>>>> On Wed, Aug 05, 2026 at 05:29:02PM -0700, Jakub Kicinski wrote:
>>>>> On Wed, 5 Aug 2026 12:07:21 +0300 Ido Schimmel wrote:
>>>>>> __gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
>>>>>> before calling ip6_tnl_xmit().
>>>>>
>>>>> Probably just me but can't they all be buggy?
>>>>> PKTGEN likes to send shared skbs around in funny ways.
>>>>> Can we get a good explanation in the commit msg or maybe let's
>>>>> keep the check?
>>>>
>>>> ip6_tnl_xmit() is accessible via two Ethernet devices (pktgen doesn't
>>>> support other types) and they both clear IFF_TX_SKB_SHARING, so if
>>>> pktgen sends them shared skbs, I would say that it's a pktgen bug and
>>>> not a reason to block this patch. Note that pktgen is not available to
>>>> unprivileged users, so it's a less severe bug.
>>>>
>>>> The patch also makes ip6_tnl_xmit() consistent with its IPv4 counterpart
>>>> (ip_tunnel_xmit()) which is already using skb_cow_head().
>>>>
>>>> Zhiling, please add a note in the commit message that ip6gretap and
>>>> ip6erspan do not expect to be handed shared skbs given that they clear
>>>> IFF_TX_SKB_SHARING.
>>>
>>> Thanks, Ido. I'll add a note to the commit message explaining that
>>> ip6gretap and ip6erspan clear IFF_TX_SKB_SHARING and therefore do not
>>> expect shared skbs, and send a v2 with your Reviewed-by tag retained.
>>
>> I'm not sure if it's too late, but since a v2 is required, I think it
>> would be better to keep the skb_shared check: that will avoid a later
>> patch for the pktgen/shared issue that inevitably will land, possibly
>> via the security channel.
> 
> What do you mean by "keep the skb_shared check"? Return an error if the
> skb is shared before calling skb_cow_head()? How would that avoid "a
> later patch for the pktgen/shared issue" when other tunnels are already
> calling skb_cow_head() without an skb_shared() check (they clear
> IFF_TX_SKB_SHARING)?

My my concern is against possible regressions. At this late stage of the
release cycle we want to avoid them, even if there are already similar
pre-existing bugs.

AFAICS pktgen sets the per pkt_gen device F_SHARED flag unconditionally
and push shared skbs when F_SHARED is set regardless the NIC priv_flags.

What about addressing both issues in the same series? Something like
the following (completely untested) would do:
---
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ee64f3012321..a7126d639586 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1385,6 +1385,9 @@ static ssize_t pktgen_if_write(struct file *file,
 					return -EINVAL;
 				pkt_dev->flags &= ~flag;
 			} else {
+				if (!(pkt_dev->odev->priv_flags &
+				      IFF_TX_SKB_SHARING))
+					return -EINVAL;
 				pkt_dev->flags |= flag;
 			}
 
@@ -3868,13 +3871,15 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	pkt_dev->svlan_id = 0xffff;
 	pkt_dev->burst = 1;
 	pkt_dev->node = NUMA_NO_NODE;
-	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
+	pkt_dev->flags = 0;
 
 	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
 	if (err)
 		goto out1;
-	if (pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)
+	if (pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING) {
 		pkt_dev->clone_skb = pg_clone_skb_d;
+		pkt_dev->flags |= F_SHARED;
+	}
 
 	pkt_dev->entry = proc_create_data(ifname, 0600, t->net->proc_dir,
 					  &pktgen_if_proc_ops, pkt_dev);
---

/P

