Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206977;
	b=ah/l5/zLk/S/jbNxt840N+PUBHL2a0XWxPxJs5F68RjGdWaySWX0v4j7qjuGqx6JLgHs
	 75kp9TVFq7gNHWOtdQcBydov67BgjL16os1lwnwqSnmJ4SfOY05mHWM8XMPO0P2+N2VjE
	 RyGwYVjcQE9ch1Llg5BYebLXbricAukchByDOp8fM2YGm9TUB9REAwHh3jVypbRyxeisa
	 xzJR+C/TtOFo6du4e3kojgJovAyNDG6TbHpG8VeK8XuV16K3HCrOfr7qb17ZZPcbTAO/B
	 js6dh4tAryC4yRzfinQNHUWsL0Y0KaFLiuiVAZyPNu8LtIczOmdVi10dMjEsDHMsY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
	b=RQ7fLeoWVgONXMRz1AgxxwxYb1BplJS7io/eVZMv2mgO/OyJJz3zu5haC+Rivq8TcbGh
	 lwt5Ss7zJ6cifhbr8H8bd9buAJgi1k2n2nyq/8mqRbKvIUz/0fO/J+9QQCO+h+UNpKVna
	 rSQTiRjfUcXqUkLOBANaf7aqcBATncgZUZWmwUURnUB5iZ4yNQZxc/JTlMklkAL7gzSln
	 VFhLwDqxhp+DA4mv/CXKPrfbyeC5co8/ThldR4hwVjbMGH26CTMJZbtvQauVuv49N6F+/
	 d+LXKWWI37t1lv1yQVaSd3BI7VqCvcrj1kZirsh0SRI20hba6e7XEDhmWrpGoraDq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCAI4bv9;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60963606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60963606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCAI4bv9
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so2872537eec.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206975; x=1793811775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
        b=YCAI4bv9xSVcIEtZZaopTpLKWw5rgxidiA4KHd1ETDF3VFw/DfKTavFs9CaBLKyh/5
         h11acdL2CovSAMzz8UNgDnNvIY7iNaXLMJHjQ1cFOxKPtBNItZrHUHc3XHoe4utkiNCD
         xqK/qjrVFj4WH0kg157KhD5X/Bv0VswUeRX9pPkCwSP12x4UH5MTBZMD36slc96SMvIk
         h5qqjOvV5XE30Bw3pjMH21OLn1MnqaSlIkoZWrumIY2i8x/5NkIlwpJNXc4AKXWExkZa
         wcBX9XnWB8A8VndSqWrXnPxdwqbNZsrAqVMaWIllbrG/dBN8OAp77B3wV33PgFvvJ3oS
         X8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206975; x=1793811775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
        b=gwL5rzA07BqWBkFWXmoPsGWJxCP/9a0oXpAait9BDzdhwUNgjnqSg3Uh1S3Mg0QsNF
         nPiWlcdIbzdw8gLrfGi+hFkhGllEJ5hZUr8mMO6NAa3Qsvw8X+4srCoVtt3BjJ7OQCzo
         DX4oO6CD7veZMlE9pAgg3BBzwMHu6pjNJFHC92GqFJvml32vYfEbTmnoFzeKmvW3QlkM
         pD0GleboIzrba1S66sVRP0lA+MEWy4O2e0dfjJGIzu5CwLfxZIOkMGDiLCwgl/NyMYNi
         EzGvFmyerbd2h4FvRUAAbn69eE7KKV9AnFxkpx931qtEb+UCfl4eE7HpllO1Uw+XGQ2g
         ZOmA==
X-Gm-Message-State: AFq9FYJyR7qxb5m/OQavDhntc9ptziSlXBQEs2YjnTkhgzF2K3rgg6PS
	4k5+7iNvBxEg8wgv96uuK8ZHnNtI+REFRY3hUmjCRbhfIinGF0nFkt9q
X-Gm-Gg: AYBFou2CzRrmY991aDIZR0R9CTJSjI78h9HdIHcCMkdhTCsY7huWqIlygh2rCcj/mOB
	w+6TUOVGt9SSrBPXexX0t16KEh2ZkQ5//j663P4GELnWF0DL9n8udzlZnyJIpXfmOJqO0sOTfAn
	gPtnnjX2ybxpgQ/JkrA9ACHL0KpfdWxzgfQawdBwYqquqFEjX6uq5g1dk0j1eZ37VYXqYIbjm3X
	XlxvILD5TYO/ZZNbY8uZbvfegUspCMLL2kTeQavj6qZe4VNLB6qS8dTMEAsQ/l1v0Rv0N6A7EG6
	iHZzkdcjz1c3q4SOYUbe7EmXW4RwT41mFqzQLjVgFKp8aU00PyyNrXaAYrX3aIfI15JXv/W5Jah
	Zc3e51w+91KttrRJfb+PPRJo2mquinVKfEcMYR6axYlvmpvr+pKDIgpYZMszASrJ7F4QFdDI9ps
	QcNaVQ//9MnNjDuZummudamgcUYix5IeWU2uI7lfvf1rLbcmvhrKxbsJDbRNz2jlyH1jX30qIIf
	VN/dGweNucaEov0vlI2EL+IbRi5BVoXHkNLWktBT+bFlwHkWysCZZ0UwoPoDV3Mh9iNYIsWWArs
	L2/A8MWCHVE2ZB/6+EhhUrkOpLvYZAE4daBSQRMO/QNTYYkN80w=
X-Received: by 2002:a05:701b:4514:20b0:181:6b8:31f1 with SMTP id a92af1059eb24-1a9494d8c4amr124363c88.10.1793206975189;
        Wed, 28 Oct 2026 10:02:55 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316:67c4:cda1:9c81:43af])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75ef5b2b2sm6832139c88.15.2026.10.28.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:02:53 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andre Brait <andrebrait@gmail.com>,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
Date: Wed, 28 Oct 2026 13:02:39 -0400
Message-ID: <20261028170239.28606-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an skb arrives at the driver and the header length exceeds the u8
hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
are sent to the card. If TSO is enabled, some header lengths will cause
the card to hang.

This was reproduced on an I218-V with an unprivileged Python script.

Fix it by disabling GSO and checksum offload when the header length (and
checksum offset) would exceed the field widths. Compensate for a
software-inserted VLAN tag.

Because of a quirk in the ordering of ndo_features_check, the skb's
transport_header field may be stale. If the skb carries
CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
no reliable interface, so don't offload it.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..370776657d100 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	/* Do not offload packets whose header lengths exceed the u8 fields
+	 * in the descriptor.
+	 */
+	unsigned int hdr_len = 0;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		const struct tcphdr *th = (const void *)skb_checksum_start(skb);
+
+		hdr_len = skb_checksum_start_offset(skb);
+		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
+			hdr_len += __tcp_hdrlen(th);
+		else
+			hdr_len += skb->csum_offset;
+	} else if (skb_is_gso(skb)) {
+		/* Work around untrustworthy header offsets in this case. */
+		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+	}
+
+	if (skb_vlan_tag_present(skb) &&
+	    !vlan_hw_offload_capable(features, skb->vlan_proto))
+		hdr_len += VLAN_HLEN;
+
+	if (hdr_len > U8_MAX)
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features	= e1000_set_features,
 	.ndo_fix_features	= e1000_fix_features,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= e1000_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

