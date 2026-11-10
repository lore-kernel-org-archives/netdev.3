Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307787;
	b=pkA/j3BOQVcPE/UFfyZGra3GGPccsZlTG9hqkyWflEYzkCPSJG5jrMHOW0XeUz3xkKKN
	 tPih/jv9aQ1b9fIcdaCkt8umuf7LfxYjAFNFk2EO9P45zY0HC4T95b7qyEijAjq8/kWhm
	 iRIuA/F7NZ7PQqfi8/WbLXRzRtrCwVuhRLy7RGMRlSM1Fr/r2NTvJszrUBAHVVwnJOo3h
	 GAgEk3jgwfw9MimjpyLeK5ZOmqJc+G9nS8eodRdwDMOM+u/d8QYST+Hd9MopAFfD7t8TA
	 mTGHfzoWVTTmmIGJ6ELCfwMylZtPlwStV6Ikyt/1lNiUbG9J9oYo7riNmUMhaonH91g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TtZhYEtABJfA2LZa7bPQ/zz+wzRCh2ll5SwHuH1Q5/g=;
	b=ZfVVtwpMY36orgZokV5XJbAYw6RsC8IdmNmwa83d6ZPxKhwgIaoa+0GAwS/oA7AQWZv0
	 ARo/wf/hKGuLqKp8bOtU9tFAQXBhdBRAk9dnh32iRrD2T33ILqtuas2/MyvBnlj2unFQc
	 THeMOwVMrQ55Qxo6WyYpnrgHX6XBtVrILaertMIXTLIjzdVy0KgCTC8SgOy01Tj0vZa8G
	 BfYNvQkEiJeQWUfIkxIqnPiUhf0RHfODCtBnhE92CdpnW7z0779bZF1JhnugBmnCyEU3q
	 RHYahfPjR4rU5dWVHhr5zadhqWu2HMOaURF8mBw9GDO27vBHkuVUFCM/xXyZ6unPBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVmeAA0I;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EF606A335
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767EF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVmeAA0I
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed06b725fdso14076575ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307787; x=1794912587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TtZhYEtABJfA2LZa7bPQ/zz+wzRCh2ll5SwHuH1Q5/g=;
        b=VVmeAA0I/x5Jg8HsmZJb5VdfMpr4zhvPv3CVsEBanr1+33/kKxnJC8xDa7BnpQLcv/
         g3OvBUvWv9kSAIb4H8BXwvkXW8UnuDZ4pacWN4tKtw2wLtSB5nNza+xs7OIms/gyCnO3
         Q2XgvSuWKWrkrGF5t5dXCHMxppLCcGJOaMrWNI0ZaDOKYYAMUx3cCK6nw+2CWQdCpRcD
         u4sFJX46QFkwCADxE5aPQRYY1IefSihldQComcFDHIDZolxkxh5lwzXD2TERVddeSgsJ
         tu9V1NDZp5ZzrAAirb4EVt7KaoqbmoCxT9iqdA0L7dbr2GkbkwbcpLDl5aJ305uZ7oi6
         IkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307787; x=1794912587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtZhYEtABJfA2LZa7bPQ/zz+wzRCh2ll5SwHuH1Q5/g=;
        b=s5GicjyPsQdo00no0+EttRk7JjEC9c5cmXTJgaGzKv9gh5re08obQ50t1jYUrcpB7Y
         Ct8zUOXal9wblm5nIc4Y1si8HLst5iOm3WPZ1++G1VyC2FSJTsAcge6ssaQ1q2k0TXpH
         vCMskGW4hRCXKc6aeShBLR4KqRqB5NO0q4To25ZqcjWDHHEj+sQjJdkl6xa5iCuVwXTY
         OwxZCbNtBFZCE6998flzkfIprH3rxhyyhht4jtqoXRFN/11UuTcsNman1kxtiOjxKLwx
         DSTZvcjM1AHIO6xTzAqEBMyUKF0doBagJk6ohOD/jg2OBtQ3zRw6fVDGH7ugoLS36xdI
         72JQ==
X-Gm-Message-State: APuU4Z92KSgbWTtPzHzudDr8CAgFbmrOJDpDbhhW5iTiG4CnvBdbgGdG
	Ymch0yqfHuWL1NIlqATmMi8pVpJktOFbTk5HDNiLsw6KP83TLfWRy3c+JaQctChK
X-Gm-Gg: AYBFou3rx86NjcnO/USkaasvjdRhGDfPwtBDkq/DGLeJKHeHOvHxXKhGIV1xcILdS35
	hELQoel926gi4zx/u72p982lhIEMSw3WArZ/rztTncQ0+Y4AVet3SSq0eKWxiLe0qltEX7TB6tR
	A06kVKjpmusLecSa28yHqsyywILRrBS4hVRBLdXcWMqYIQ/H9P7RvN5RvSYp8kkHYh6HaHHRD3l
	XNaUK+26P8AB/yLgZH2wk0/6Oqb0TEIw6u98cLh0n3Njq+8xb6VCBpe4AbumT3QS3qRAzcxjlc/
	Z9LPbEWaXMTiBEce/Nk5fBAwc0SiseESnwiA/HflXTPwXTGkXyCX+Nfds2tzkdyctF03IKTu/jt
	Ddf0r96X1IJgytxBymmBSb8llKtjZEXJ83crhLJ+QOgSPy9G68WSOhJ4Ka5bN8C+zPD7drukgxM
	Jjloddwgc4FuCutX92yyMg9IZS7wJCa7eAClFa+4senecjIEMFtTAZ/YSW4b/DTu4U/QS0gBtow
	wBJR8zLJDKTbnrooGPRdYEDdpZ+Ja5SXzN+rlJyqjwBF2lNpViay//ilpPQ7JO196AwhRcx7p9+
	GRWt0o5VQwkGn6EyT4Z6FXILBOla/C8up7KNsjVOWN6sgUIWVSel52xr
X-Received: by 2002:a17:902:cf0f:b0:2e9:5313:8f7b with SMTP id d9443c01a7336-2edb715dfe2mr16779565ad.9.1794307786556;
        Tue, 10 Nov 2026 02:49:46 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6214:1250::1d3:d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d906e4sm7337815ad.40.2026.11.10.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:49:46 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/3] net: dsa: motorcomm: ACL fixup
Date: Tue, 10 Nov 2026 18:48:52 +0800
Message-ID: <20261110104930.223598-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Various ACL defects. Found by LLM and manually verified (on YT9215).

v4:
 - reject action following redirect action
v3: https://lore.kernel.org/r/20261106073806.112122-1-mmyangfl@gmail.com
 - also unset `reason` initializer
 - fix action resolver again
v2: https://lore.kernel.org/r/20261103095514.338700-1-mmyangfl@gmail.com
 - withdraw patch 2 as it needs another test run on the device
 - fix patch 3 to align with software behavior
v1: https://lore.kernel.org/r/20261102071119.3435180-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: motorcomm: Fix extack message on unsupported TC actions
  net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
  net: dsa: motorcomm: Delete the ACL rule of the port being unbound

 drivers/net/dsa/motorcomm/tc.c | 88 ++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 41 deletions(-)

-- 
2.53.0

