Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672953;
	b=3bonKxELwXnG6SaMFOGVRvBK2/ArsAbtaEnlDOqoeViEOq4Mb25UPHHjDDJTV7NS2GgZ
	 0gNz7GKhLSYNIkj913YoNBN8n54EEJ8z2Fey9TTq04z+lmn8oXPs7LicLCk5YIrvb/cD1
	 3d9CVHdclkdKzbsowLCq3h4D0V1bdSvEDKQ1p99/Ssu4yN5T46CxdiHin7iyHUj/RPKuC
	 u0+LL7uO3qB7ORQ9pfHdDAYUYwYesyrsLKSj9vO9K8AciVOy5Eml55XkggYTE6WgMxqBD
	 zgNR3Pg8pLnZ9C98L/XO+n25jFwMeTPxLrBwpX2kEX3z85gxyZNINUdrpsyBO5sgDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vm4X83cKQV2cViXLrBy8CdaLxj8kNgfl4SZFvLru4UA=;
	b=KplyEc/9KLMsC3c+zqrpO07VSgwWQ0NG8ZWyrR+DUlQtwuk3ARqIiBX5PX77+ZBAQBvs
	 BKFYIfX/A/bipxSQdb3VP0HzZoXUz01T5NhY05SqqrhycPibzLGa5NOgArmzhUFK25j7l
	 iJjomSvS/oYtJKv+cDZm4+3NyFKdyB6A2p3Nyq2DPAqSyWRWHpa+cOjEqIeMWCKGeL+4p
	 dzFK65mzXo88M7+++86G2IPcXwX3qPfTxzXttXHisYpuS8eV7IMdXF4Jq0kkuuPs1L+bw
	 uhc2pdVjoAOQZTCHEqKLLyDHbDXcrKlmM3e21t15i3WB9OvArV+P4Y6bdCNPXfsWqRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cVCvVFAT;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A577606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A577606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cVCvVFAT
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c79f306e9so41141126d6.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672952; x=1794277752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vm4X83cKQV2cViXLrBy8CdaLxj8kNgfl4SZFvLru4UA=;
        b=cVCvVFATvdScw245CyKvTmebYWLuxo711JncUEkQxKeg+Hm/sz18Kv+VF28V3pa2s+
         B7ojHUfI7xqJY3q+hCjhiaORNbyUcpYgDxGNCX2c5ClpIYD0PKZuE/iy67GTO1kTfrYz
         olOUx8AS3BcI7Xwbb93M8vvm53IkAadp314ke1mCsE0E5n5DWnHbWb4ifaBj2WrvLscR
         M7XrGqSU8K3kzKyAecn7ZfyJx+OhfCC1YcJjAPj6KKDGYreZolT9xPHaDgORXIkJ2hQr
         X6bWo50HtX/8U4XjeIgWN5rnyGZ33k4n9DwYnZS9ucm9mmfZTqe5tjs4tOr8EyOmloR9
         oj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672952; x=1794277752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vm4X83cKQV2cViXLrBy8CdaLxj8kNgfl4SZFvLru4UA=;
        b=tPat41RBtgG7rSL+gaRj1PiGbv67W47k1dZ4gPWxDyGLNVKbgGrZ1A7sQcEGLN/Hjy
         t+F1t9UWfqcn8Cn9LxF3nTqwTCW9bh59r8Y8W/oOCCIop+6YPlhtd0P85/FpIc6A82CP
         otnFj9nH+YLgA0X2WsS7EopqeketEPugRvJmUJq4JRG7p0xwecFwqMxsUJRFRVkeqYct
         EiiXClgNhBXLdhu5777Bkef89EFmNwfMM6ccA99qQ2HrZMYK1NwysICDZva8q+5Dlr+t
         ZNGWNsjUbGLkD70/q9C/kC6MX+7TrKcQOxwQt0aAiNNW5T6zUvEHeL2qNyIez2L70B0X
         8QMg==
X-Forwarded-Encrypted: i=1; AKwUvBxaa0hyMmKG+p2xe0i7dv//hSEgUVXf+jnq3Dp5DlSDapa/DcMUwVyqrTzXQNLpvS/fyX38hpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+DLbP5w+4mkAGZ91A6bF7E+1HJsiVYv0eMIdWH67AWgQ0bqAX
	UdUHxUkI1R8Ey3yKo5lTXcbyq4q6CoaAo/bXBA7UznuBW+FaJ2c6QitoWe2PitGdxGg=
X-Gm-Gg: AYBFou1KJKYR2nWoW6w3lCwIPLsypMgvoXDhxfzO6dJX72xYtPxRq6nTQEG/lLrce88
	lcmxHji2qM4RBY9thdA7VojIL/+wvLxNcbHfZGkjG/y2d7lIVwN40FWv6i6hnzxpyXOgNNEEfz2
	QDC/8muDHg3wJu3PZ8v90MI8SjyUmWtK5BTK0YGiVPhLe5H4epKMVGmFK5eL9lloAcqm9RKpw6x
	+wUsysx1nkxWS0IKNiGcKlOG0NKHGIyTqV3e5Y+2RxvsA/j67kRFlaLQDxLdyidFZpETVA0TKF6
	6xF7jYwFljVRecThE6JziFFq2u28/66DxNeoVnewruPurzbw8+7WyYc1xOIM53gQz7nBxZEo3Xg
	OYjF17nPa6aSJRkg3xupk2ENxpeK2ASs1+Q6khNkbNdve8Hv4IkbmL6drIMfDVxJ/9/nDR/5++l
	Efv9lVYTsiNjdL37xG5UUXrDbTYzxMUmTsGHN2oMbAc9PMZF1v01i23HTpULFOwW0Ev3dNZRaXH
	lFfVRhYJ83DSj4sjzI1bSN4c3bH1nnnuh3xH2n3qxFK3VLR1RvD2XcVefK3o4PJAU6WqSKrsCut
	ghZH5e3cDNJd2sA/rv0ef/35WB6KBJvODw88CnwCnsRLHQ==
X-Received: by 2002:a05:6214:8588:10b0:91d:35ff:cb53 with SMTP id 6a1803df08f44-91d35ffcdc9mr8100016d6.37.1793672952196;
        Mon, 02 Nov 2026 18:29:12 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f401f5sm106359816d6.19.2026.11.02.18.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:40 +0000
Subject: [PATCH net-next v3 14/15] net/tls: don't BUG() on leftover length
 in __skb_nsg()
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-14-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=1573;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=jtewRftckK13p/nQalxWcrhfGpFqhqstsSARsz5AoHI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKU+bYXkf9YXXl1oclL2Gvz2UVI2gtqcPepXaQA2KpnhXr1hun6qZ+lqT2IAQi6KyF0liU25rYL
 0WlL33F1eag4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_nsg() counts the scatterlist entries for a range of an skb with a
copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
skb runs out before the range does.  tls_decrypt_sg() calls it on the
same range it then passes to skb_to_sgvec(), so a bad range would BUG()
here before it got to skb_to_sgvec()'s error return.

__skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep,
and tls_decrypt_sg() fails the record on any return below 1.  Return
-EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() for
debug kernels, and say so in the comment above skb_nsg().

Acked-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..748ae27f2b88 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -142,12 +142,16 @@ static int __skb_nsg(struct sk_buff *skb, int offset, int len,
                         start = end;
                 }
         }
-        BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
         return elt;
 }
 
 /* Return the number of scatterlist elements required to completely map the
- * skb, or -EMSGSIZE if the recursion depth is exceeded.
+ * skb, -EMSGSIZE if the recursion depth is exceeded, or -EINVAL if the skb
+ * runs out before @len does.
  */
 static int skb_nsg(struct sk_buff *skb, int offset, int len)
 {

-- 
2.55.0

