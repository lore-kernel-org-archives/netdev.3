Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514693;
	b=L+3wcZ+y1cJ4TwbCqY7EqHzVaPYpK2JTJPNMgqPCDcXADQscjxjR30RvmSxEb9Yo3cV7
	 mVRM4mlapxx0bFy4N7TCw46lIEV1eaDKJiyBX1f6Mn62hu5QS4ORjBDoUgwzTIJl3H7Tc
	 cWQdmLhIAiG/00mX3mF7hyDrJJRGAWptJNMYj03h40DyAwjC4AH0k3XQg+s+uUY+5Skf9
	 ggoFvzn5BhavcBxu+eO4cxDJadSQwKIW0wE9SE2xwu+1AsodisYHlQF/6Ytu5CIn9lYr+
	 xcN08P2KAUaqXdvtvBgNyyw/Q+LqC25fH8nYI/Iz43xEMyFZSVSgzY11FpTcxUL26kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514693;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=NXh/568rxveSYCJoVvN0lsdLPnnUxgQKvxNkKzZOZw0=;
	b=5c9/+4uOUWyGAuZPg4BlqaAlWPBOvFAvjrW2fLsV52mYDiuaaGIxE/JJwiI2w3vT9JTH
	 S1aGZC9+5jmxmXhs9czZCi61jSGtjXUNXm2hUCvusLuDujTs0X7DFCj8/nwCUROsgoCXZ
	 uoDF3jGGyOAtWfUX+RtngO0CCBl6+TBiixeURAxWE1EfVzN7/kipVP0lKKDh+x9rXuskF
	 MZeawtIoPyYE2iw+psvPefxLDg8Jz3TszEbAA4sUOgTyKGl9N0IP0eaVXqy6wvM0dk5aQ
	 UnPqR3QbHlK0S0VFYeia1/GHbiU17z7iaKHOoPmLJvpDbB33BqLPsHrP9s1QX82TeYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=DyENckvx;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B90FF606A326;
	Tue, 20 Oct 2026 16:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=DyENckvx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1792514690;
	bh=NXh/568rxveSYCJoVvN0lsdLPnnUxgQKvxNkKzZOZw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyENckvx5dK3mmklisX9cwDjMlDQf/UiqqK4kcHy4Ywq7SQD1A2wSi8pEDU1Qouy2
	 UrVqpyi8Gbznv8MnWRlqXMsDgH8ZyzvYRsbpSXTZIfGJeyJcBmwkl56eGFWdOix6TX
	 Y9FaBGPGUnc7AHCg9/UdPZNx4d/sf673rhFkassLwWiwmMK2GudQsdHUpKh+NngFdL
	 kHQ/Q6D55QpJ8hBBcD/P53+SjS+wmQ6wjhiz0URRSWkJhLUuy96CGUZiAWB/ziBHDV
	 QY6yN+K8DHRCV9mXBPz/WTWAIyeO2btKZJkAVunMI3C/SdlDAjaDIM+q1+ZtN/NDTY
	 NTlvARQ/K5Chw==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id E66626005A;
	Tue, 20 Oct 2026 18:44:49 +0200 (CEST)
Date: Tue, 20 Oct 2026 18:44:47 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
Message-ID: <ateaf9-cY50Goz0j@chamomile>
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
 <ee955f2c-c97b-4505-a996-f7d7c5d2a3f5@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee955f2c-c97b-4505-a996-f7d7c5d2a3f5@linux.dev>

On Wed, Oct 21, 2026 at 12:10:32AM +0800, Qingfang Deng wrote:
> On 10/20/2026 11:08 PM, Eric Dumazet wrote:
> > Le mar. 20 oct. 2026 à 16:30, Qingfang Deng <qingfang.deng@linux.dev> a écrit :
> > > 
> > > Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO packet
> > > forwarded by a bridge can retain hardware GSO features and reach the
> > > driver without software segmentation, if the egress Ethernet interface
> > > advertises TSO.
> > > 
> > > To force software segmentation, clear the GSO feature mask for
> > > ETH_P_PPP_SES in harmonize_features().
> > > 
> > > Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> > > Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> > > ---
> > >   net/core/dev.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index a6951ea08961..27483a2ad747 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(struct sk_buff *skb,
> > >          type = skb_network_protocol(skb, NULL);
> > >          features = net_mpls_features(skb, features, type);
> > > 
> > > +       /* Ordinary TSO does not update the PPPoE payload length. */
> > > +       if (IS_ENABLED(CONFIG_PPPOE) && type == htons(ETH_P_PPP_SES))
> > > +               features &= ~NETIF_F_GSO_MASK;
> > > +
> > >          if (skb->ip_summed != CHECKSUM_NONE &&
> > >              !can_checksum_protocol(features, type)) {
> > >                  features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> > > --
> > > 2.34.1
> > > 
> > 
> > Ouch.
> > 
> > harmonize_features() is called for every packet, GSO or not.
> > 
> > This is a GSO-only problem, please do not add more protocol-specific
> > tests in this path. gso_features_check() is only called for GSO
> > packets, and the cost there is amortized over all segments.
> > 
> > Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
> > because of the can_checksum_protocol() check in harmonize_features(),
> > and fraglist GRO packets (the main use case for PPPoE GRO) are
> > segmented in software anyway.
> > 
> > This leaves bridged, non fraglist GRO PPPoE packets sent to a
> > NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?
> 
> I reproduced this on a VM veth interface, which advertises both features.
> The real hardware I have is an Intel IGC but I have not tested with it.

IIRC, I could reproduce the issue too with a virtio netdevice.

I made this inaceptable patch (see oneliner patch with protocol
specific update below), so the recent pppoe gso support kicks.

I guess adding NETIF_F_GSO_PPPOE (similar to NETIF_F_GSO_SCTP) is a
no-go to force software tx path to segment skbs too?

Thanks.

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..07bf265d0295 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5514,7 +5514,8 @@ static inline bool netif_needs_gso(struct sk_buff *skb,
 {
        return skb_is_gso(skb) && (!skb_gso_ok(skb, features) ||
                unlikely((skb->ip_summed != CHECKSUM_PARTIAL) &&
-                        (skb->ip_summed != CHECKSUM_UNNECESSARY)));
+                        (skb->ip_summed != CHECKSUM_UNNECESSARY)) ||
+               unlikely(skb->protocol == htons(ETH_P_PPP_SES)));
 }
 
 void netif_set_tso_max_size(struct net_device *dev, unsigned int size);

