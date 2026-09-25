Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF03AEF34
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340523; cv=none; b=Xd1VhffK6od9nN4DS0K11S8MDLt/H3K1hOMtvXsci7HwFpeRNsLPQkUK+fapJatPA1qAnDGe1BoZJV+BeRLeSRrXVS/aUrKmVgOg+W1kGOuVr87Z5dFPH5GZ64tys0SBuLXLyU1Pe9LYi3JiTAOXasoPg6YuCgRk2/Iy1GHydE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340523; c=relaxed/simple;
	bh=XbzUyMmKMxpVEAInJzGZ3muXE0ZojrNqKjiWkB7PQu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iiix20j0IxzZuytQu5LQS2hPFowS2CIpPUBjMWDTFPvJBpmcAqmfScnNZW4XvheoAGZs5niXcraEyi5fxa3tSnv2GMOEsEDxUA965h0Uj4cyF5ox6obHhqkETU3PBqrBIs4N5vI1aDBTAPN47xr8QdXPRtc7dVuJvhIEMKWwfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeCcz3jo; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeCcz3jo"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a30521ef15so6122411fa.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790340520; x=1790945320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jddCxJdKIDMQLQTTnYlvRhePSCbJJTJmIzc5BE+zJqk=;
        b=NeCcz3jolk40szygqa8eGTITJXSs0/S1Mg4uqWTnnb49Z7h/Q8/GRaILCCsD0ITWUe
         wE9SFSUenJOdG+/dd/uAAGNwrHFBGhWMs8iZoKKtWZBU/dXywVG/x2J3CzjynePIPexM
         fSZev/Fo56bj2sWhK7bbeMxl/9cVYaQm/Q3r10+hjqTKTg2f8G2ywpVxfiOaU0kg2f9O
         o+xsHaWCWzcuYuNEN8RGBZfWwIL9nwLLvuHYaz6FGsHbV0ZxnelRbrLSHSgTEndKNYGY
         2U58dzjO9R/aDEiyiibB908hjbeIX5cOb8mb8FE8CrDcLBNOBK6kbCPUasHIG5aGtc6g
         d62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790340520; x=1790945320;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jddCxJdKIDMQLQTTnYlvRhePSCbJJTJmIzc5BE+zJqk=;
        b=SR63MUiUY3+xLeBa9ok3CZEo+Ct4psGO31cI2xEf7NqWGOgWBXQ9umVCxuWLpfgnQm
         aYsITmu6g3IJYa0YF2gs+xvEL7DNB6AqawKx8SaJISd6E9og4b9XQTbF7CzHagoyHhm3
         pSqXFSMSOcdbj9tTkMtIo3M4KQgIc6h9+lXxfoS24HA2iQUTUb2T78SOWV+d+iLT1+ao
         gYjKLz77avdCUxNNx+yE6d/mQQhrLXT6mssmyqB3D2dkYn02oTRT2u33WsLeAw4bVq7j
         iEaW1fFi7OQPztqzRcfHwXyh5P5S8pp6t4GKOFIcEchVvvfMJgL3/38oaznkwiAs8cof
         9NAg==
X-Gm-Message-State: AFuF++nv+SdDC93s+gQKwYDWZyTf8mFOhWA5zOQODw3NL2Lox3kpWC8J
	mxvDCBqf09n9wf0+XDzPmHZUmnSDxFhdA25qZCq1zoLeJ9Rz4P+cZg/ixeDO
X-Gm-Gg: AYBFou2+G7UDrl7kxym2EZiVmyb6lcbaV/du6lTnzoWvGU36Y5Q0lccUxXkz25YcnHQ
	cX77MParYA7D4I62khQPbfnuaLxauTK3dY0RYsHUj4KMUNmPQccvtUHrXaAsvhKX/AGizxHIWMY
	u1BK/T9CQyNXOh+iw1dcffltdSfURVlV1FKWkNqG5zad0vYaHlEMW0/u75bGenD0Wbhywr6Tx2w
	Y6LMY3G/Da4UULtchYhUhMg/3BJk0vEjvz75DUYS13jJJ30dNaaVZ4QtVz7bgELsM/WjXGrtxVq
	7AoyXcD//9/CtCnHgrDdIPWwqmDrdH1l0vGoG8v/rbgDrroVoTV7UPV20//yOqMqk0W8JPagLkm
	S/J/1wPgo9kZTKDPECKMAZV1vggtSU5IWb01z4dOg4ebkKD9PDSK8sMB/p2XrQE0cZoFafSJneH
	8srISvGsCiQmzzLrRzJiCzleZj5l5ibtORhixm9UO01KtMZilP83DFfBzZUy+LsEtuRcJzuA9Ll
	rT1IGGz9lvMlVPQD/i1xBUU5T2JjLwUietB3h/MtfVs1sijrITY39T4Cr8ybUWhff5xAAnf3iA5
X-Received: by 2002:a2e:bc16:0:b0:3a3:7681:6d6c with SMTP id 38308e7fff4ca-3a64c7c7544mr4964471fa.21.1790340519487;
        Fri, 25 Sep 2026 05:48:39 -0700 (PDT)
Received: from localhost.localdomain (91-155-233-101.elisa-laajakaista.fi. [91.155.233.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a64c3084afsm5408941fa.27.2026.09.25.05.48.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 05:48:39 -0700 (PDT)
From: =?UTF-8?q?Ilkka=20Lappetel=C3=A4inen?= <ilkka.lappetelainen@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net] net/packet: prevent TX_RING byte count overflow
Date: Fri, 25 Sep 2026 15:48:29 +0300
Message-ID: <20260925124829.6595-1-ilkka.lappetelainen@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

tpacket_snd() drains every SEND_REQUEST frame in a TX ring and adds
each valid packet length to the signed int len_sum. Userspace can
recycle completed frames concurrently, so a single blocking send call
is not bounded by the ring size.

After enough successful transmissions len_sum wraps into the negative
range. In particular, 65536 65535-byte frames followed by a 65007-byte
frame produce 0xfffffdef, or -EIOCBQUEUED. sock_sendmsg_nosec() treats
that as an impossible return and triggers a BUG. On systems configured
to panic on oops, a CAP_NET_RAW holder can panic the host kernel.

Stop before the next frame would make the byte count exceed INT_MAX.
The positive short count leaves that frame pending for a later send
call.

A two-thread TPACKET_V2 reproducer triggered the BUG on an arm64 build
of Linux 7.3-rc4. With this change, the same reproducer returned the
expected positive short count without an oops.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ilkka Lappeteläinen <ilkka.lappetelainen@gmail.com>
---
A tested C reproducer is available privately on request. The exact kernel
configuration and complete vulnerable and patched console logs are also
available on request.

The test uses CAP_NET_ADMIN only to configure a high-MTU dummy interface
for fast reproduction. The vulnerable send path itself requires
CAP_NET_RAW; an existing active interface can be used, with smaller MTUs
requiring more frames.

 net/packet/af_packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7c83e01526ed..d2c98bc0de9c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2874,6 +2874,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
+		/* Prevent the byte count from wrapping into a negative errno. */
+		if (unlikely(tp_len > INT_MAX - len_sum))
+			break;
 		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.50.1 (Apple Git-155)
