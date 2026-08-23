Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F5331209
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509615; cv=none; b=u6zDmaUQllDq3W8+L+hb1Q6hM3XUobOuRlBXeN4CJK1CnQJGlToS62gKyXj+BL1xKvr2Lg2LeBhdWJjgMoe/SyqclEwL0saAEIUmUCsIg4hK47IsUCF+hnPYrbxf/QbGzfx/cyEiEu6KLuT7x5Ey5yxhmEtlj/ZBSG3z+gQDI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509615; c=relaxed/simple;
	bh=NI/vd15x9ayqa8B9OLXei6lm2x90hAg80Ev9KaWKZmU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aLl4A9H/MH/qA+CHdnSXEWMFXF5mXoKwJIikgjtVqZu/kkLmWgkjDWylz9rh5/nGZoVc7XyV836ipNWQXtLID+iKARsObMUG1T6DturBwXzIeCRcQe8SACtNU3FBZ5wePpbNPGDPPKKY+yvX1coQ7yvFgZIHZKKcEsVwomWHl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnie33qa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnie33qa"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dbcb505578so31928477b3.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787509612; x=1788114412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9yhn/D4Reb+vaPw1yG3zuBbBZAJP4oShC6aum0klUYc=;
        b=pnie33qabS4vkS0vgrumIupjrCbaMuTfs3DfyHclmrA3z88bW8EAGGEMUCmR9PSOk9
         SF6UYCNTMHdQL48TnDHZVPT1wQRju+AtQvWG7w3SJmKpF/iruVR72QlqHE0ec0vgSZDD
         AxHjLw3hMJoVq8wX3INUFxBYIjbitsI9LoWDYErLBVmq8YHNC3X3sArd4xqzQrTvwfrJ
         76z+hdV2EHjwLvIYqey+94tBcdyuUMEN5yInw4zKSy0PwXWe0HoM1vTukf/osG30wmEQ
         jKsDXi6jIyH6rJW5EyVaySigl3c6BEkgEkMVpyC7xsHmQXs5CBbOEXd7UT88EUijEFG3
         +djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509612; x=1788114412;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yhn/D4Reb+vaPw1yG3zuBbBZAJP4oShC6aum0klUYc=;
        b=eB38H0eL/tN0Fc4Ub8mWnjI3SzrZuWoQ2dtKud7zJT3KYqJmMcGeROM/MbYHPSaO+o
         xoDHOxBL6rULLXE+FekY8dxw7CPJ+OvKHx3Th1FkuG5gUQDExVnMqplkPxFy3GAhdIXT
         C1CmQpqJuUnQw/naUaYX7nCRI7ohemMmNqvyPud8ilzWiftpjr+hw/rwBp6Evfzr1GC2
         GIYa6EbN0MIar3/qaXL2lJFptUtTfGHXJUMqBOP3KDoTs3RhRv3PKtAoCUf2UEVNZh2u
         ijlVkCRKJjf7+LmlUIBSiRnXyqJhlchrVy492Mq7sML/ZgT9/miXrWaGCNdBgLBlFpGZ
         VoSg==
X-Forwarded-Encrypted: i=1; AHgh+RqJjC2bs86yxGsFd08tl5PK5mw8k8Gkp6eKNhcLFQuPYdaBUrMBzygbF0gzoK8QNLj9vE/nZAY=@vger.kernel.org
X-Gm-Message-State: AFuF++l022CFUfp4zuM2/Xsoh4xF9ocE5ldjO/mStT2mlY/XsCmwe/EW
	qbM98Mj4jmts907cEPD32Nsyf+qr0wKcMiy5gGfiOti7RuEhgu3Ppyh+
X-Gm-Gg: AR+sD12xNREJ0PMcloYFWVfuFX0Qw6MFpmyxmOeLkeSL7Em8cOjxBVEtLKJ3iJkC2ZV
	itfnZgJRizMNUEn9aCG/BwGnyuim7tvuT3g4bEczihs9xwFsf7dm824Nt/Pp5yqWqvFjbF9t5GY
	4Qwy1tAwcyEvhs8ss6y84xkOQ780omzoV9XOLmPCsjzV11VX4C4zJOEnmklG7YkplOUNc2aGPMU
	SslcKYVejnKNIeyLsTyUr6w5dwef1nsGvGX719UtmxJ0bIdtV2NSxNqFSIpocTH22ulA9EoAHiJ
	/UEiiWFb6ANT6dV95IA7RBYIYRs2fWAwF+QSV2oDj/F1LEY3od02qIQHnrXL8Y+1+YRWKKj0O1C
	Ujq8/wNMc7FXF60eEilZnksBmZKZemCwUN3AQRfJ2gWtEs3hAPBGH25ijhwG/AoAzRjn7Awm8nr
	bpRwI5z/qgGLmGN4xuKLRID03He/MGhoSrRNPWGxh6wPgyTNNQvn49FWwZ7OMj/TrJHpaZym67j
	8Bb7o5jil9dzysXYMXeEGjRhLQd1YveCviOru8Kpg==
X-Received: by 2002:a05:690c:c384:b0:825:6bb8:5521 with SMTP id 00721157ae682-849f86bcf08mr63349117b3.32.1787509612461;
        Sun, 23 Aug 2026 11:26:52 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caacaf1e9sm23126677b3.23.2026.08.23.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:26:51 -0700 (PDT)
Date: Sun, 23 Aug 2026 14:26:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Norbert Szetei <norbert@doyensec.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Kuan-Ting Chen <h3xrabbit@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 dev@openvswitch.org, 
 Jongmin Jang <payload.jang@gmail.com>
Message-ID: <willemdebruijn.kernel.18d6500676cf5@gmail.com>
In-Reply-To: <CFAB292A-674B-4C14-BB2C-BB8830AD5659@doyensec.com>
References: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
 <CFAB292A-674B-4C14-BB2C-BB8830AD5659@doyensec.com>
Subject: Re: [PATCH net v4 3/3] net: skbuff: don't touch shared zerocopy state
 in skb_tx_error()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Norbert Szetei wrote:
> skb_tx_error() completes the zerocopy uarg and clears
> SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
> SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
> shares, while the caller only owns the reference it is about to drop.
> Through a clone it tells the producer its pages are free and drops
> SKBFL_SHARED_FRAG for an skb that is still in flight.
> 
> Open vSwitch reaches this with a non-last OVS_ACTION_ATTR_RECIRC:
> clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
> do_execute_actions() keeps forwarding the original, and skb_clone()
> does not privatise the frags here -- skb_orphan_frags() returns early
> on SKBFL_DONT_ORPHAN. A flow miss on the clone then strips the marker
> from the packet still being forwarded, and a later local ESP delivery
> decrypts in place over frags it does not own privately.
> 
> Skip it for a cloned skb. Nothing is lost: skb_release_data() clears
> the zerocopy state once the last reference to the shared data goes.
> 
> Fixes: 25121173f7b1 ("skb: api to report errors for zero copy skbs")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Tested-by: Jongmin Jang <payload.jang@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Took me some time to wrap my head around this one, because

There are two independent types of zerocopy in this context:

1. skb_zerocopy(), used by nfqueue and ovs to create a derived skb
2. skb_zcopy(), skbs with "zerocopy" page frags

And there second has two variants:

2A. original, such as vhost-net, that do not support refcounting and
    thus must be downgraded on skb_clone() and such
2B. SKBFL_DONT_ORPHAN, that support clones through refcounting

The bug here is modifying shared shinfo fields of cloned skbs, so
affects type 2B skbs only.

skb_tx_error was introduced for type 2A skbs, predates refcounting.
For type 2B, the signal is indeed generated at skb_release_data.
So LGTM.

> ---
>  net/core/skbuff.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ab3d161247b9..b9541329f1a7 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1417,10 +1417,13 @@ EXPORT_SYMBOL(skb_dump);
>   *
>   *	Report xmit error if a device callback is tracking this skb.
>   *	skb must be freed afterwards.
> + *
> + *	Does nothing for a cloned skb: the zerocopy state lives in
> + *	skb_shinfo(), which the clones share.
>   */
>  void skb_tx_error(struct sk_buff *skb)
>  {
> -	if (skb) {
> +	if (skb && !skb_cloned(skb)) {
>  		skb_zcopy_downgrade_managed(skb);
>  		skb_zcopy_clear(skb, true);
>  	}
> -- 
> 2.55.0
> 


