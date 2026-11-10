Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307791;
	b=RUDTJd7Xn1TEe4It1QfIs+Dp+s5Fl0tOVfEZNFwJBPTZ31fWMnudBh0fh1TWUOAoAqF0
	 cGgNMXIOBnYXiMC1+XhbcbngXXlxGh6nMuPGAvqiKCPcg1T2AcHnVg78h1Ie61ZG24hm9
	 12FCGXgKYiPxM2LFkukpRQyhdomU1RwIk+v+81Z+WoKfycPLPvQ4YD3P1WvYex/Z8sS3S
	 SJPbVxbO038n6zV4aHT9E9TgDD/0tam5q4HPHOOmTrD8s9J7R6ZwKZ+PQC4DBuY8bHkJD
	 DBUOipWUOrnLNVMmAAcQW2/7lJSLMf80Z0AA8H1SLRF3rjmUc5OEubUADcuD/S6269Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jHE3vz7ikpP7qewD4PpZ2JFR+MDb2MgvZURmQJe0rMo=;
	b=hAdOQ4pyQzi9xZvvZ2vVQVnsS4n8/dPpdbrYhmXpVuyi3DwBeajMwjYuIaXlDHBx0ya/
	 lKp12yOm3GcODUbnISPKN1VS/b3kEbKIOPBYnE9FQkeMVJ3yrs4ce45Sx/lhEInG/P47c
	 xTU0WFluq9+WVyk9w5DgD4OsD0+d2p2uGOWneFtz3tYSqY8ZUGVuoyBsHz0NLLzgRX5ag
	 VEcNjzgYmIdmXjK9kVBpe6008/x6vM7ic0XC9TbRz9u2LBYIBQBMkjMbcMPLDot/93LCD
	 d4NYI3GCCiP0c2W/ghR1p2taD0CJNGz4V1yM7lndOLS7tgdV9wNYkEMiTd3FeXKpxNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhlDgiwE;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77F606A331
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA77F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhlDgiwE
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso727230a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307790; x=1794912590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jHE3vz7ikpP7qewD4PpZ2JFR+MDb2MgvZURmQJe0rMo=;
        b=lhlDgiwE/QiGvBotsWQX/Irm4b/bTqrcqi+0qNxELwtCdEEX3UatmO9IxoGh+MWohO
         NeSOmrYkfv11ataMI4qUwkQdcb7AO/2kAa/NNAaHN5mQD5yjHbV2+uqTR4uG/X0FovLb
         30Nn9EY0fSOyblr08dSe7RmUan6wuwixOHZB8Qd05CDUsOLyJzbEomHhf+FaQt2sS7UA
         JdL5+PAIAQdKPfNBJ8IPWs67a8cv1Ar3wD8Ylq//zGzUD6q5/eSCfsbLtTz00RYm7oI3
         4YP8JKVrcNVy6V/Wy/XoRC85XQVORC10sCpULD1BCX6dZfXQ5nI2Za3n2ez2ppGd7xy8
         sMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307790; x=1794912590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jHE3vz7ikpP7qewD4PpZ2JFR+MDb2MgvZURmQJe0rMo=;
        b=UBiSfIu/QtdaLXONZJiAnNRm4rF9tB6vejMJr/UIu+c/d6ZRQiNgu33XTGLoBpxw8H
         h6lGgkiroUJyIRFo8WkzbPuibSWzkxqGOt0S4GetveK7I66b1Ht3nY2x/VxU6iEgZ1QB
         jXBntdoSwwvZn5YAja/O47bMAw+3gid6KfCf0UGA69EbLW5E7a7wk2kFLqpkVgYs6SUp
         xUpBAumtrDYo6LLXDhttO3jcCt/To15vy8BaDhmYZRW6cYCeAWNtnjj17Dxy1D3YuWxi
         lQ2k3X6ASQ8LEHIOQyo12StrrObe8ACGt8n6SKNqc3k8BqBuBqQ0AOMCMpfnZ+5O7pJA
         urfA==
X-Gm-Message-State: APuU4Z8f7NZs9/QWbdqNo978V6bh5cKXJ3FfH+EU8yEYb/vDhOcBwgkX
	FNJph84TEgTGNWyz2jFJCdBYA9S8SuMCbJWUaWXQUL0l4cLF/qtzBAi6/Yzpafw1
X-Gm-Gg: AYBFou15WNFa6rrbwetWI4sWqT2COBnU92P6ZFJhFZ/Tui4geCAeGRc4lZV0MtJWmvu
	V6e1RjJdFlcWi4olXmoA6Hpu1XYx6xlUZR5fw4XU/aL0uyZJ7vvbsjRZHGyvzwRiN2yPnhM6jDc
	wHp/R25QRETbeYyy47gr/acBTNw1LjQCiWD2mDtllOb2IQDit+rJS+nMUmZI4csbUDDLE2LdjIY
	/5T15B0wR98Hfueb31Dz1jnBmiRRybhbaVmCrfZADY1cVTQbwd+PyZLABdqLKudccyRypIbwmaq
	EnCBVqtKMA10H2p6yuJGpSAG9eaOPpGpKdoAUlacuiT7jwwzIpJhOJPP0C0CzPj+TkMLnnnHCgP
	xknhH9+EtFUZgOiFcxjUwPE0hP55ySO2QKwvSgXYzViyM8RR0jrGvzbgjZihYHfGKb714tGOJkW
	Wkj0ab5AIxU3g4+Rj03Qrsn7MqLtpz7vi8U0kO9aWgX9q+nQA+BFU0Enz9RT2CinSRc8ub85lTP
	QlTQIkvqHzvphLMXTg4LKVEOFmnYOjfLxsmZb65PATmSZWLdutpweYkhA5jKP/ruYmqCLhZ8CaM
	BOH/NbbswEQk5seGT9jXu/HOHboEExCv3ix7Fc9Xl8TMAy3bMMSmLEj9
X-Received: by 2002:a17:902:fc8f:b0:2ed:948:b68 with SMTP id d9443c01a7336-2edb90b2eebmr20574655ad.9.1794307790115;
        Tue, 10 Nov 2026 02:49:50 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6214:1250::1d3:d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d906e4sm7337815ad.40.2026.11.10.02.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:49:49 -0800 (PST)
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
Subject: [PATCH net v4 1/3] net: dsa: motorcomm: Fix extack message on unsupported TC actions
Date: Tue, 10 Nov 2026 18:48:53 +0800
Message-ID: <20261110104930.223598-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110104930.223598-1-mmyangfl@gmail.com>
References: <20261110104930.223598-1-mmyangfl@gmail.com>
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

No extack reasons were given to unsupported TC actions. Set a reason on
the default path before falling back, and drop the now-redundant
initializer of `reason`, so the compiler warns on any future path that
uses it without assigning one.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 9dbd61e48fee..90b017a11a1b 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1034,8 +1034,8 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 	const struct flow_action_entry *act;
 	u32 *action = ruleext->r.action;
 	bool seen_priority = false;
-	const char *reason = NULL;
 	bool seen_police = false;
+	const char *reason;
 	unsigned int i;
 	int res;
 
@@ -1122,6 +1122,7 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 			break;
 		}
 		default:
+			reason = "Unsupported by HW";
 fallback:
 			if (cls->common.skip_sw) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-- 
2.53.0

