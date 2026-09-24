Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E38337BAB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214942; cv=none; b=gao1Eqvblcs2RX5+VcV2AxDFSCI71MylMih1yjELa6xXaVKk+p2BCEh5Ofhxw985JGnvRcMW9t8mObO4c2+fuga0F+8iigIAeNlKuKj/ofRx3CMdEdwcAOke3XHSVBXLZUUYreN1Vevz/8XOLAsbPSRMavPZbU7ZH8mgO0Rghjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214942; c=relaxed/simple;
	bh=JU83A7FeRE0GPwIE9Rrr67qBh3WgTB88AswTB3byS5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXSDu3tMlXsTuhagkGvdLlArZ4gf37awWpG6BLHN5lNLxh6dqeh5EcF8fdDQXafgsFzO03Y34tTQ/MP2/5LF3KY9/t9Vs+dN8Tx6PyJtrEktAUPBC2CUOu31QqJqcmqUYn83R1k2gh7rd+wWkA53+fCL/xgbiaW+3Mr+UZHnXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VnVOp0NO; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VnVOp0NO"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so888634a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790214941; x=1790819741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iI6ZU2OOshdX9j4JmC3ptQbrdEensuWozjnvUV1wRwk=;
        b=VnVOp0NO7POKK/bDUmR85cf7kWcnbnL9g69XVqatY9us39QVfSypAJ+wcm5WOkwjGl
         zl/lQinKLrbMwWDOawE0h7qICwrqKEJf1VZYD6H2kqc9SaqTlruz8uAPOsGJ4Jg5lVqU
         RPQzefw1rFPOndQJ7e4qTixdZ6gYbQf5hWy3gZz+Sct2PROOCNneLF2VD3DYrfV6c2rc
         7AsFDJWFeFLk55SGJB7iH/My71DY7F/YD44eCo13/2Fb9O5uYo2vQQmBtyt7shlFPVXp
         DTeAop6gbAzr0bwEEeTKrzfLqstHqI1sS/NLU5RZ5ZSaBAi8PUkNX5bprMarFwB2D3SJ
         SisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214941; x=1790819741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iI6ZU2OOshdX9j4JmC3ptQbrdEensuWozjnvUV1wRwk=;
        b=UEI/R3qXdb9u9koVSWpCKX5e6SaZAcpQc2vT9516oKq/OhDlus4RsfpnueTv999QBk
         1849cAPkOk/C6/bwLnSsdXAMWXALIKBMKcLZI1Uo4sFQ+tyGESKfL+XBfNMAVYRY1rWL
         blLuhyOD/boFlsCppQ719Vr7l+T0/Hmza1Mxz5vY30JMVuGGnz3klsZYKw1z9IDFB/0Q
         Kppbnw1yum0jpWNU1X3bYP5Rrc42nAwsKI0qsNxwoo/IKCLMRMrBGa5cPAutuldTwmsz
         ZSDp+WgM54oBomFTj9VNGvsmfv5EKlmTqCDhSOHkKUTy6qMm/CeYQq54SO6YGvY7qNgo
         XJqQ==
X-Gm-Message-State: AFuF++lqVf/NfXnkL96ULW2DfDOOja3eN/QUP5OBrBa3E2OO+S7csWXd
	XBOFIiWDdnArbJu1r4TN8phLwA/D3d7H3HIiXDi14mfc/HMZYOTrGbnWXBXryyrqqs5xWsXKnWX
	8Ed/6ZxlU
X-Gm-Gg: AYBFou2o9aJFP4uvxXTNtZfzgEDZ086Xk+NFM6GOpUYn8xDzz2RQv7m1BMkZwI5KIYX
	UpJIVlGtOVfMgPTHNxJ9E3moIrh9p98B1cnQ9Ku0Lazzro7J5hIDxY/zD74Fy6KXQrGop2O2qh1
	3zCanPPIoM1VKB2kJK25VDlm+n5ETDE3HRs0/i3+BjBfHbUEyQmkmf5SIfmLHDokkzK+fxxjQhZ
	MXX+PzSe6HqNnlA5wmf1ZaheseWxjmVOOP4FRJHeZTcU1pQIn4CGky/vfmMl+hf8vOWxzl/xaAf
	fNhKNSSfi8uaB8bMlxEjL7cety9EjGr/73tGt0rwmbMKjjvBJPWqnbwH62pOL3n2CYyX4rriVN8
	ByCxk81RjpNwC6U8EqOzjeEZPIjP5SCggXG1w46+0NgsxY6jCiS5otgBrqhx4M7mJQHrwYDN4mV
	zCDDjhQWFtBCMQHfiaCZBz9Hq9Xt2wPzReWEOd5Qy1QMdM4A9F4m34IwrBscFE50d1
X-Received: by 2002:a17:90a:e7ca:b0:39e:4c81:6c65 with SMTP id 98e67ed59e1d1-3a0987294ddmr906924a91.32.1790214940739;
        Wed, 23 Sep 2026 18:55:40 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([2a05:dfc1:8bc4:feda::14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a087c09c05sm2119917a91.0.2026.09.23.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:55:40 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	weiwan@google.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: sock: serialize SO_RESERVE_MEM accounting
Date: Thu, 24 Sep 2026 09:55:14 +0800
Message-ID: <c81fe8b34001b9a0275fe5934f9e8d577c2f6bdf.1787150300.git.vega.cover-letter@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787150300.git.vega.cover-letter@nebusec.ai>
References: <cover.1787150300.git.vega.cover-letter@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

SO_RESERVE_MEM updates sk_forward_alloc while holding the socket lock,
whereas UDP receive accounting updates it under sk_receive_queue.lock.
Since sk_forward_alloc_add() is a read-modify-write, concurrent updates
can be lost, leaving socket, protocol, and memcg accounting inconsistent.

Serialize the reservation commit and release with the receive queue lock.
Keep the potentially sleeping precharge outside the lock, while performing
the forward allocation and reserved-memory updates under the same lock used
by UDP receive accounting.

Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko
Closes: https://sashiko.dev/#/patchset/20260711005955.1467140-1-xmei5@asu.edu
Assisted-by: LLM
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/core/sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25..6d35072a2792 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1022,9 +1022,11 @@ static void sock_release_reserved_memory(struct sock *sk, int bytes)
 	/* Round down bytes to multiple of pages */
 	bytes = round_down(bytes, PAGE_SIZE);
 
+	spin_lock_bh(&sk->sk_receive_queue.lock);
 	WARN_ON(bytes > sk->sk_reserved_mem);
 	WRITE_ONCE(sk->sk_reserved_mem, sk->sk_reserved_mem - bytes);
 	sk_mem_reclaim(sk);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
 }
 
 static int sock_reserve_memory(struct sock *sk, int bytes)
@@ -1064,10 +1066,12 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	}
 
 success:
+	spin_lock_bh(&sk->sk_receive_queue.lock);
 	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
 
 	WRITE_ONCE(sk->sk_reserved_mem,
 		   sk->sk_reserved_mem + (pages << PAGE_SHIFT));
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
 
 	return 0;
 }
-- 
2.47.3
