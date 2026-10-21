Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590436;
	b=Qnma1L02GhgO9J5kZXjQpkxaYZdBVV2MobYcfxCMryUgT03iqxiIXmB/GPciESDDpCe5
	 nBIkJoy7VpQ8q7qw7B2SOlciFW74+QIsb5pqtI8l+1FhPcC2PGGT2dYxDZXDjkx0++qCV
	 zD0ikKTej+h3ZBx9nhTi8soXFbovKzh8lnoItmhZxGapLa2uiCfcuFT4W57Bb+Bl50O71
	 /GWSHHFli8LKNe7ZoqctBzOw+zuh8KEPHdWHqIA+GD+psElfkU7n0oKzas+rhTg8fCnZT
	 jqwADHd34ybs16Z9P9B2FNSlkdOPNBnqJLh+LU2Wgk0Jpu4B0k02AFxvh3wWcZYhujQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2aRCuku2oKEDF0Op1/pBMZnZUn6snlu290Nklz94qvM=;
	b=3jULJeAFu+1YZ2+BJGBzVgZZuVnDNGPy2bH+Nrt3DS8q1njaLVWm21CTcaR7K+Jcx7ry
	 IEbSHim18AgLnJXJctbxevDhuJh2pq1vsohcYBocuePY9ULnUM7j7GvmFkeX44I1qzqkQ
	 K6aYyCxseKuLyzvf5/a7DdnCqfBOKUvfg7eSYqQT25ql2tjirDtImq9rP2iaYyeKB+zKC
	 6Zz64eE874k+RzchQGOEXRsr/trSjc5BrPTKOkocW8G8HQogkLr5CCub751ulqPDKN0OD
	 FkV4rCK8NauujEStqdvKZuDwraCxaKFz+X1rD0jRynyYveaSt9j6g/BceXvWG/eiPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=XBcZ0cHs;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A8606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05A8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=XBcZ0cHs
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-534e6545939so5844061cf.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590434; x=1793195234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aRCuku2oKEDF0Op1/pBMZnZUn6snlu290Nklz94qvM=;
        b=XBcZ0cHsbD3wjSJ41+HTbGpSMbdy0qo2oyFSyW3HL8OBpHTPobyMDhObfjnAZa1Sd+
         OfheMl6sVbdfFFNYZk5jTuRF/UCvhnxovVJ4LvTe4jkkFy5HnoixHu9BN5vtBCxIuNv2
         6JdeR+4Vp874zgPrDuwyK/xKZLe5U7og6AgGTaK9MaC3adSkECJaQIrUmkdSnbWNp/ZK
         PsH8CiW7duX7ZGkFRpHOxYVRorcHwTp/9h2urQzjgsccdNlbx9p7juOVSdqbrc4k8tOl
         UWXgaQHnmA/0+uhoFuesQ954RX/J4izQA4gLdp+7UmVW0+uQtLR0uB0hIq/jS6bfFqJ0
         HGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590434; x=1793195234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aRCuku2oKEDF0Op1/pBMZnZUn6snlu290Nklz94qvM=;
        b=IREazmkPHBmEbTdGNzAeI/SMLsceM+XktPaMrkuypD8r8rNXHk9Hu1/sKEmsmEpUWq
         CZQXwJJ5KxuScX/QeOXv/J3baW+CEgrWmtBJubKgs7JQCM7sr/SiSW446y9lQBeeaxHO
         hy7tJxbZkEvmXxVqhnHwk7xYRj3RkUaVcWBaszT+yJMk3DTPoZcY3uTYatvh9MdYPkZD
         TWK5np4z8VLmwcVx4346Ks9xOKzTDb8H8dpgUid9lfY0/VE9NCf4V1wRJp4+mbHtKNYq
         nU36tSyBxEeL19BWohbFTjOXEhAxmico56xYPRz9SXhc9APHOQ1S5C9zNsxEwriRkeyI
         fuNg==
X-Forwarded-Encrypted: i=1; AKwUvBziCBU71JimJ2TXhbH14b6mDRVasAQBwiD7a1HQvaWPGqENdndHzOlqQ6M48cHvcJSG3bsFz1I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLVEmlrZeg09kpbQPmZ7Orr5cxxSPR9QaWfik5jPc/FEpyQu2t
	xxfRq2Olhn+TPrRtW70Jot1VK2yQIDH9qgBnw2rl1BIW7q/ksiaBonA+osLswYuhrGQ=
X-Gm-Gg: AYBFou2+L7Yuc/5ENM90jJm3/C6ZWI1U9HbGqp9wB24iSrhxJH292sfVqXUNxvsXnLT
	jkAcP9+tiYuAgiL1MWQBBgzBA7Jg1NdcyHzr9GSOl8U8kfe7lVDBJJIjms64MQhK0dPyGCYsWWq
	PueldImqeC9j2xNKsv29RuSPXgsjGEGj8Tmm/lAZYamX9bN1vo6obnMhgFl0XLKiWXr92BrG83G
	iHcBanxS16efcb24XvO4XEyi497pXZI8uHJVYkI4x4/vsxiMlbxVquS2TSdXVhPG2a8Ljgvnbzi
	Y6DwhLAV40Ri/718zud8EI6/+SMhXVxWEigAPHRyhVUNTChlgpR0mFS4dnQMkTnLrLjoVTLB10F
	SHClWznbYecnHAjZB9xRHxDjA3XC4mmORgm42276tjKFTY4F08EAyGFcAbDaWJR/IauQKfQuKeK
	y/ToVBmIHaaytLupERxEMVf2eRFkNPMUK+O6YEoqWd2sD7YXsWqUBD5qw+KEhkzuol//N/gg7bq
	/cGBC74tGWw+YvH85LoihXeNCFsKqRjmd2jTLsp1A79bZGThEzrgKvHlaMOylLG7dGO4AIf
X-Received: by 2002:a05:622a:400c:b0:535:baa:a78d with SMTP id d75a77b69052e-5369b4f46c6mr30150331cf.10.1792590434551;
        Wed, 21 Oct 2026 06:47:14 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10baeadcsm25487476d6.19.2026.10.21.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:48 +0000
Subject: [PATCH net-next v2 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-4-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590422; l=1895;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wii8wzXlG4ePvSd6K5rd8H498XoB8iUyEaQEAS7r5bk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFXNkJVl00uSWJUSJGE5ur3ZFVCzw0/41zwWUKiPaUfI51HMPUlDfMqmqTrCEh6QYjM2gM13Our
 wstomOnSWpgM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When the device can't checksum the protocol, skb_segment() computes
each segment's checksum in software with skb_checksum().  With SG on,
the segments share the original frags, and a devmem TCP skb keeps its
whole payload in unreadable frags.  The devmem MSG_ZEROCOPY path never
sets SKBFL_SHARED_FRAG, so the __skb_linearize() fallback is skipped
too.  skb_checksum() then warns and returns 0, and tcp_gso_segment()
writes a TCP checksum that doesn't cover the payload that goes out.

That's reachable with tx-checksumming off and SG on: sk_setup_caps()
still gives TCP SG and HW_CSUM, so the dmabuf send is accepted, and
harmonize_features() strips the checksum features but keeps SG.

Use skb_checksum_full() and fail the segmentation with -EFAULT when it
can't checksum a segment, as skb_segment() already does when it can't
copy one.

Found by the Sashiko AI review of an earlier fix for the same path with
SG off.

Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 40d2dd20d47d..88ed2dd99dc0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5239,9 +5239,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 			if (!nskb->remcsum_offload)
 				nskb->ip_summed = CHECKSUM_NONE;
-			SKB_GSO_CB(nskb)->csum =
-				skb_checksum(nskb, doffset,
-					     nskb->len - doffset, 0);
+			SKB_GSO_CB(nskb)->csum = 0;
+			if (skb_checksum_full(nskb, doffset,
+					      nskb->len - doffset,
+					      &SKB_GSO_CB(nskb)->csum)) {
+				err = -EFAULT;
+				goto err;
+			}
 			SKB_GSO_CB(nskb)->csum_start =
 				skb_headroom(nskb) + doffset;
 		}

-- 
2.55.0

