Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7024455177
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774719; cv=none; b=ktgwU9O5WkX1zbnPm2VNvLCzkl9FiT/tWQ0v0pwzyaRgQo5W30tToPeACkH3nymhuYURYuUT4Ya8ndDeOWErGWw/rxo4dpZ6zDDC15jJ1+IPhkSqUSF2Z6v3a5s/mQ+PHfYQtfhNWEyypCpZxM1g2ow1W1yZn0mBjjmILDaD+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774719; c=relaxed/simple;
	bh=q8AQh/Jdl7kkNyeKYqO/b/5eoQwQe5/Rapj/D4WZ5kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC2tHEzhydoy5i7rr0/EEI3mVGQinskGMPQAWOmj+vNiyzbcEhroxLCCuKyH6nHWYQvVxRolsXoiyfjYasclrlBVXXrwfMwgP9o3kgUWEghT4O8C6CS+hnldJKKkoGWYgW0Oinl165r5lUShI87lc3CefmSQGR0kqu6z+ds9O7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2VvqeLM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2VvqeLM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39647184c73so3960965a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774708; x=1789379508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRV3VX28th3l/YUKQYZU4Bx7v7ROHkdn+qJgfLM6OBo=;
        b=h2VvqeLMs4tNgNCneN8uXEd8WJ+7JcP3V1+YtTup0gKIkVmXuxVBp45ETh2AtgUfEF
         hhuR6U3hTumrSdRUq5Raa9v+Nni/JZBW/LxnnSxYmZGnjIVxSUfGnOBQIU6s6fw64fD5
         Rllai7THzUzeTva7eIvAPRt0RsUMOltxWzPsPlbd4x0cm86mzy+bkJQZWEXXy5Dt6cnl
         mzh5fs7W0AhxbbvGsqE9FkdrUtCVuKsJYevz74vin/4qfWZqA6i+kq65fZECEZ22iFp5
         czbIsO4Q13PgoPMaVuO7MdvgASx/Y9ug/hkCREtjReIseA0TwfbbfHtgkjcm7PA1iufE
         4wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774708; x=1789379508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRV3VX28th3l/YUKQYZU4Bx7v7ROHkdn+qJgfLM6OBo=;
        b=g7dshAYbzXfvUOkUCyPQkchpuFJH6SogwSKPNoRfKXBV2F/OGeXTXynmoD1SClwMhI
         4AUvc/uuviVHYA/kUpHLR44Jclt61P5etvFTJ8AG9Nq/offzI8PPFR6RdTzakvRmYoOe
         +56Q17WNz2W9s1zz5B1Y5QuZWpiB7GI/Asbkh07IZX6X97dnuo2pkB994WAARo5Y66sB
         tzrXV3tldiEystriRLUbkZNVSKeTKValk/MRMXpwndV3XYEhelzSzkF+ohX6ej3A9qjT
         IAu1sMIi2qM6shkuT1TfIayzCQVUepNHbqKSjPWYCXqyUznd1zPoM1d9Y0kg1THmY0aH
         +2lA==
X-Forwarded-Encrypted: i=1; AKwUvBwP+DzxAzD7Vs+IIeh6V5W9R8ZRPhcK3ddiu4qzEXghhKZymwvdJ0JMu67GCNJevxIciPn5vps=@vger.kernel.org
X-Gm-Message-State: AFuF++m5V9eQz2CJVW6d33vvrgny9wFMIgOkSJ8gIOehbplMCSHxxeHW
	LhxLQiXk/2vm1XWLbTbL7yfxYuNNXrq19UIwneYcczSpk0Fs3HQKL9RR
X-Gm-Gg: AYBFou0JqOKMcRPrqlCgeGcLUep9V1au2ow5dC2x8UV2udck/auKmgv7eiDMAMpfJO7
	b0De+FC45glZWzxSm2mmMYf6sRkHPJmKoWBv7UbloCNptdTXg2ci3Vdi5iWFUIZ1MFvQv03pEfX
	0XZKIRniyg/DUQgRbLPuJiQ5kMU1OkWnbo6lmvO2S+IjoxwdZEKUfH6HCg5ZnfQ9zgLLaaFzm0P
	EkEj2Ku/qvDubpl8TipN4E/G8Bj1u4+FiIS/ejTCqzohRGc4fH4cXbXHsKBr9Pk+X412vnCtOAN
	WokVwQH0LFoCcqIFQ7K1kYxrZJ0UEw56q8fDUhsj+4E4LzTvVa8DYSiHjaHFYpCQExzK1IAc3xq
	lJ00+hnQT9iODi6i4lTFE+Dn1uw76hr/y0g/5CnSv6VG1Edmbid9SJjrgVkcCYyoqQmxavN/aQa
	u7pWoJTpXrCSUFjPhow/qU5IQGWDbZiuFbxLkORYPbwFCx4+9eUtYDS/xz3CT6I0pk/IVLZb+3n
	yOREhhwQKKkQw==
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39b07fed101mr30316424a91.10.1788774707944;
        Mon, 07 Sep 2026 02:51:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm30049167eec.1.2026.09.07.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:51:47 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wpan-next v2 2/2] mac802154: fix typo "substract" in comment
Date: Mon,  7 Sep 2026 15:21:32 +0530
Message-ID: <20260907095132.21244-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095132.21244-1-hemanth.selam@gmail.com>
References: <20260907095132.21244-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to wpan-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto wpan-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064346.3288-1-hemanth.selam@gmail.com/

 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..8f3968d2e516 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -521,7 +521,7 @@ static void ieee802154_if_setup(struct net_device *dev)
 
 	/* Let hard_header_len set to IEEE802154_MIN_HEADER_LEN. AF_PACKET
 	 * will not send frames without any payload, but ack frames
-	 * has no payload, so substract one that we can send a 3 bytes
+	 * has no payload, so subtract one that we can send a 3 bytes
 	 * frame. The xmit callback assumes at least a hard header where two
 	 * bytes fc and sequence field are set.
 	 */
