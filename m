Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02437B40C
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494863; cv=none; b=CSSGNuRxyQMtKQd+SRREAlQMAA1msSBRfgIbj/oIspoiTnW4hLi87Iogu9z4tuP/9V832xHEcN5uYo0XbvF0K8mfFc/WEx1j1R/g7TqGaceaUkdWQnKC3t5GIwonLBKYiJ4YEunNg0f+PDj4093MBYOMxScMQXt2IpRX7/0holQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494863; c=relaxed/simple;
	bh=wL5CQOPFGQgN9kAiy33M9BaGwqNuBlYJXqd4ypXRE2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8hTiIu2mjTpyRLZ2BgZLGBcymA1N6TbaY0fmza6a/eRkd8l9TUCAZ9mKNg6RzaMyX0H5s+LM8blww3+qfZ8SJDv+JDGpAWIh0Q/D3kR0v3UNLFkJtDsAvcLFddGMyhaWo2k6av0SZIKAS8MC5KT7x/R8aXnb1YGpK0or/kdUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6WTv3BV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6WTv3BV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso19136635e9.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790494860; x=1791099660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaMkfOeTY7WAaAgMRdIMicY7X4DXefg1bKqcol366WA=;
        b=A6WTv3BVsduxgfzbzr2nHA7lFAQa/ptaAEnUUUHz9aL2fq7KxPs+WGPpnF7qCgVNs7
         DuOmGmKtdjE3a52aMFpWDTii3NVY21EMpUFVZtWsLEIlylAhNBN170VRdaUkGmPKHiz7
         RG/X+dVlh+zblRE3PjiQKL5NxKE/4Ox+IJHJ8SC4gNmW1Y034lNR98czCTzYO88urdR3
         dfm8boY54LkCtcnPTu9YgVP8AyatbQyfBWjhQouwP2zezjelIY6XTn/4RnlR4yHDZfi6
         qKatZFuoxpU9cVhDkmRgFF9HAb1Riv8oMVDRPC/B61GRbAune2mSHqlJywM38bHb+QG4
         0MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494860; x=1791099660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaMkfOeTY7WAaAgMRdIMicY7X4DXefg1bKqcol366WA=;
        b=Jno7D6lp7rSs9Hb5kLzi7DmxV/Jv0ZxoCAvppWzNFqlQ+mfqr+F3lJDbdpcMBEa7Xv
         Sx0P/PSB+ItlUjSikKQjfmeV7W9AbRlBPmesfYkMgQnI56hxYsjE2BMjRkfTNOm2+buv
         7Nn6itK4gBeCGfBvE+p8ivAT4WhGFtZJEENg7Q09BtDWCzITC1E7s1rLEEqC3+/uA4IN
         gCRMU4Z46U+f8Xhl6uaR6ktTyXRenwAdaf34FWrBv2WLQLmYS+McKD2eB5Weh9pph1jU
         j4pIGRCWR84M5dd8XlZRZbEbgVy5+Hjw8p7Gx3GV73GW6SlSL5eMz008tGIPflikxJTs
         38qg==
X-Forwarded-Encrypted: i=1; AKwUvBwPsoT0h5fL8tI+O/gfloNEG4QFn1PlRSfsbxZipwZsSJwZaf1ojCACGRl+vMFan9mHlyaR6lU=@vger.kernel.org
X-Gm-Message-State: AFuF++ny3qYtx4bf/5wL2xA1u4LWbXo/2y9yZLjwIf8hUEouXhiGt/ki
	D9IM4RzrxGjTgQ1kawYTrLgf9Rc5QypVx3pYz9eCnCJ5z0DbQYw2Vtd8bAMwIN/VyiE=
X-Gm-Gg: AYBFou1Msn6eVVWc0kttvTyO7eAQz7rfV6J3ftC1fSvZy13dQinMLYeSVHN00RYRl2J
	WT+h3+sP57eVhjGoUvrAqVsP3QJngpxrNFcY/pgtvYMUzlzpk7aNvj4eeZVBAwrXi3PDkWOlRgx
	havd/6OEk1soZFJAuVldjJ39rhY0J/m4MD4F9IcPBteeVZsmMqDPwfRfzQmWqq6ZbPgDTDb1+1G
	9TbZWRaYZ85dP9vant14ElGMPQpFzzIOs7eV71PS7YFI1q7Ee4+iv6H89sXMNyfB3ik1pABtijB
	thjQnd50uM55Viasa8Ejs8PFIZ1/JFnXj62XfCMNCzya7QgK46QZuuj85z9eb6BMIXauJ9V/DSO
	RN3R+XOD+qaTLsfyFcn9ftualeEHwNJvyRXG5fMOsFgsGVQfipN8h0bjQAWBvcOfMvwplpj4dDE
	SpQuemFBz//C1C/Gfj0dDbmVjRr1H1gTUgHk27/eIKZ88HJ0j/MVBRy6WLwdk=
X-Received: by 2002:a05:600c:348a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49fe66f4ce7mr174454285e9.16.1790494859604;
        Sun, 27 Sep 2026 00:40:59 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018dd0ffsm40453775e9.2.2026.09.27.00.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:40:58 -0700 (PDT)
Date: Sun, 27 Sep 2026 09:40:56 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in
 rxrpc_destroy_all_connections (2)
Message-ID: <arjFl-vgg5vz1WWN@gmail.com>
References: <6a73d174.5aeeccc9.207e63.000c.GAE@google.com>
 <6ab29768.514bccd6.255447.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab29768.514bccd6.255447.001e.GAE@google.com>

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git a7bfaba4823e

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..111f0844b0d6 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -272,8 +272,19 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 	bool secured = false;
 	int ret;

-	if (conn->state == RXRPC_CONN_ABORTED)
+	if (conn->state == RXRPC_CONN_ABORTED) {
+		/* A CHALLENGE packet queued for processing carries a ref on the
+		 * connection (see rxrpc_post_challenge()).  That ref has to be
+		 * dropped here because the caller frees the skb as soon as we
+		 * return.
+		 */
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_CHALLENGE &&
+		    sp->chall.conn) {
+			rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		return -ECONNABORTED;
+	}

 	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);
