Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012581;
	b=UcES3R0T6mfSHChmIfB2StX7QHgZQZzbFN3wRVv+jqtWxsy5ZAY5gNeAByM6LCJU3Lc3
	 fhtZtN0opr0lK21jfIJx0QRXj2THEcz2WGmoqSsoi1jQtCnq+5m2c3p/Va4Ll/6e4SS3E
	 SRhoWQu18kJ5n4bN4h4z0AtqpmvWaxPvtN7DaF84d+RQGGAmtCvrjqmzBnNO/YgLBCWBT
	 PDKmon0zC/aAJ+KhwWUf+0blKif60F1D7xmzcfnWrYC7iQ2T318qmEDbil8qmSN2nuIKS
	 HrniPHY6ErGAeF5VAOQzkDy8qMuBbS6bkZls4pAN812qQ5s374oIT4C2JxlN0vPBq9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W6UdDeYYycrdIuoZVPp14+bHtZX/0C9MDOpCvhR20kI=;
	b=YvQ7ajflmB0hWRBHmmP9KzqzlosoEm3tTMSzZ5Dms9TeoRiWyD6qKUwyL3er8uY51wgH
	 sbNVCkXF3FlzXJbEQ3gVdF/n6BI+X0DA11sHY4880whUOZK0io0podMGOM2mbKHczrKSj
	 nh1FzFOHQ1YyS7flesB5kgnjblQtqUvaTrRPwypQ7cZsCGodXDFW+9ANorjO+Hylzju5A
	 AinaVzIv1RtsbxqgbiWWKax7tOPk3r9OOdM5nXNBf0v2jcDf4VzEKP/ZO+4V+9b6HJEj6
	 Xgetq6CfV1iIEjP3kHurD77jm9De5VXgBOnmwM1vNR+QAowucmIUjfivYpf2Euqo2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=wvkgMr+D;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546DA606F9D7
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 00:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 546DA606F9D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=wvkgMr+D
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso1820052eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012580; x=1794617380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6UdDeYYycrdIuoZVPp14+bHtZX/0C9MDOpCvhR20kI=;
        b=wvkgMr+DOsdWJAbuLDkMmSnYwrYhaqLv2hfnZYukNU0o/7U6gxC/sJqVya/bKHJ+Gm
         fwVDaVQuKmb6tHuCifIkUDvKHLih7iwRHTckVgmtz//ErXvk7XFXbXUPiu0iZD387gM8
         brP/JawGJ/y+BFlhAKK9qV4OYVFDkTRW9buxmsyQHkmBZZtMyz+cjdGFr51ixGdBvm79
         IpvO2zg08hW2hPsFz+VF5vi0ZtRfFUvK2MabZm01tNxio+0mf29b125yuJplJuviO4k8
         ZsYh0ijQ3j9i+yF68TfbOgb5xdZxVQRLffl5npOaVBZferkOTd1k8AbX+wEsQqzkEwWI
         Zfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012580; x=1794617380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6UdDeYYycrdIuoZVPp14+bHtZX/0C9MDOpCvhR20kI=;
        b=rN+AOcwHTsdHard0C0ECAZ1LXHPHGMdI4nGhUzID6wux4njDA3a1y4L69KGM6bW0em
         8UvXhCmokUI6nHpEQg3kRPYnVoR6ziBiJOcGNsnQd7j7quMhvWkwHiOQj1WM6+DquRBn
         zxF0NZeoaPVNRWAKPTKoWOos9rrAmVXrn6RU7S5VA0w6EGvEBU8sZ6wYaPuq/g66AyBy
         4s36jKYH0rrwyEbIdVfaxV8HqxZIZvPgr/ExxVsGskLh+3n+bNTpkPLdXCTdzEQjG0iz
         uw3TlOux6mNllIRQIuwBhk46ydnSzcW04ERwBVCIvfezaTjpdVPYFPIgWU5aCHaZfxwx
         aVaQ==
X-Gm-Message-State: APuU4Z8DVNhmDZIbCaSuuqxgBX1JEzTs7aejemPWMqSKfleLtBhJ8uRp
	z5RfYE+1UGMIebVBc69cFP8p/Ea3DhdS+nDpIr5SrRffJBQaWCp8o6z00xMt3OD3AMxmd0Q8xVQ
	lygN1N5Tm1P6c
X-Gm-Gg: AYBFou1RfdJFdr9T8JsQ41YyZuBzZC1B/7xAbCvYaBxBa6caaL90BXCgvQQabsTJHb5
	tg0z8fRMcj64bYRu/qsVtDSZsls5d8hgcN80/61TaFkcYb1223B+7HbQxqHQU5DRMB1X/EJ9O5G
	JiBIlKellZwfgtMPR6Vra8CFkt8mwXTd5B9/CIqqi89abAeP5QTObmGTmiA/2f+xOqwpsem8O/z
	VYiNZfaH/emjfb788gpQvg9MzG0CAIUgst2PsxVWCQIHROGzOUPDuUijabjpAv94VEfP8upnsPH
	zHpUnFcxC2blWsoSfVEIOKrkC/kvcIhcBYU7Z4+CRXOkxCqyOc2qYq+uAgDXdmwPiaymCn8cMnR
	yKpqlWdUF7he+hK30r8Cf0CIOHD0WFVDY3HSI8Tq5J4rMrjD+0mkVTHzDljciI2OqBPLiL6+mJB
	I/qhn6JHCLLO1Fw7VA7oc+UVVvFuZj0p/5v8Dde/clI3G/mIQ6iIB+FQA4p9u+LPLRUyf4F6gqL
	BkMkCqxAnpr39W+uuG+dYUKJWpM6P0SSmZPu3r5MhNYVK5tdPLei6VmvBBnL2XVV079qkHc/Rih
	izOuK6+TaCpXJzDJhVWOFae1F1um9U/mIf/i0ZVZgcs+Wn1Zbj8CBbKjJL0jDLSgi+fMsD0=
X-Received: by 2002:a05:7301:4605:b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-36f729cfab7mr5026586eec.5.1794012580134;
        Fri, 06 Nov 2026 16:49:40 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:39 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v6 1/6] amt: stop receiving before amt_dev_stop() tears down its state
Date: Sat,  7 Nov 2026 00:49:30 +0000
Message-ID: <20261107004935.2627329-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107004935.2627329-1-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
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

amt_dev_stop() clears amt->sk and waits in synchronize_net(), but the
socket's sk_user_data still points at the device until
udp_tunnel_sock_release() clears it afterwards, and nothing waits for
readers then. An amt_rcv() that loads the pointer after the grace period
can still be running once amt_dev_stop() has cancelled event_wq and torn
down the relay's tunnels. A gateway can then queue a received
Advertisement or Membership Query on event_wq again, and a relay can
link a new tunnel from a Request and arm its gc_wq. Either work can then
run after the device has been freed.

Clear sk_user_data before the grace period, so synchronize_net() also
waits for every amt_rcv() that can still see the device. Once it is
NULL, amt_rcv() drops the packet and amt_err_lookup() ignores the ICMP
error.

Found by code inspection; not triggered.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82..3a703b79f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3073,9 +3073,14 @@ static int amt_dev_stop(struct net_device *dev)
 	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
-	/* shutdown */
+	/* shutdown.  Detach the receive path as well, so that once the
+	 * grace period ends no amt_rcv() can still see the device and queue
+	 * work after the teardown below.
+	 */
 	sk = rtnl_dereference(amt->sk);
 	RCU_INIT_POINTER(amt->sk, NULL);
+	if (sk)
+		rcu_assign_sk_user_data(sk, NULL);
 	synchronize_net();
 	if (sk)
 		udp_tunnel_sock_release(sk);
-- 
2.43.0

