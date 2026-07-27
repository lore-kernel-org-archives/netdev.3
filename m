Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23264433BCF
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176361; cv=none; b=T28ELSVP8eHkhCg1AVAf8IYhz4IoEUSg0Whod2TqGQKy0wQWl0Ymu61da0iLr27GrDdJm4i31BZ9cEF8mVNYX+8KoJEXmU54GGnqxB/wgFojG9X2FlmiWz+Ld0Pssi1JA1/p4T6V/szz3mFl36f8cFD1Xvs1ucsQI8qExzaMq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176361; c=relaxed/simple;
	bh=SXJDYsUmv5JMg6/c+xr1owdcCtCJpBAOMTufeVNb10E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGdqtfhi2970LabFQAOeokB4vdfcSwWze2OM8cTHs9CZYqnRukVLZ0x3T0vLvNyzBd3hblAKC6VbKNdqw3C8j+Wn6fPFNCllBDpL6YYdCCcvYsywz+6P7R6ujw76yLcAhpQdEC8qEr/tZrizmPKI1Mlf4XtNUXEXOdy64dYgBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f8fd5f16aso1409799f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176348; x=1785781148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PD3b+WprHse+odXNf+PGGAc9NxDJ0EKmW2InjOb5Vco=;
        b=DfEZbiDL2WqWLUog77AmZd/LqnLH/qZPkEaxL6nHurQj1hivUYYT7RfVLSJi/FCpsd
         1776zEIAihFiEfNUZTdGHmQYmKGzwSXaQEzC2wofZRhkqY0ZvCmmsCh0QJQ2uhunsb1g
         g+RwBcr0R7/7I1DyAcLwZyYd6YzZXVkUGBGD4I4NMOjXe0Rl+7S9CuPnG8MlwD4H2yzt
         ZllAepzKvjK776Pi+X1pekYhOAsOkFKu1ngNwi7WBWHCDGwc1mjmOy7Ma2UqnLKA40T+
         69XIuAa/qgq80QQsef2RAcaU9CBR5FMcLyoZ5f0Ubn10phhATIDHojnczvUULx9JHSCr
         XLHg==
X-Gm-Message-State: AOJu0Yy5pgVLUBonSBzMMJNQWFlmm8ChDqCgxC1mxM5bHB2ryolno3pU
	L/JZMXTpU06aGL46utdsB45NItHHFvpPxlMfWZYMt6lYWEo7P8QEMItwvrJjGvTt
X-Gm-Gg: AR+sD130djMa+J8N1FWF9/gBMKW/CBEF6B75NujJ/UbJ25ss3A1CFkBy5z/LFXFaaII
	JKYYnlIA47lMa06m3PzS5c4aqlqkccixLvaVuvaXATr7wLfaclvetwF8fkF2mIaF0meK7EXjixO
	GXl6wHXG9XKm2RjWEwuml1tr0jk4ZWFAR3Vg9g4GySElia+YgPORbHV8LkskCUJgPH/EcRujQtw
	9snN6FqN+lCqqfrHHho1tflNzitfJwNpLD00GQ4M+5rNd25SUfDwa+P6XkJOXT5JjWu/O6AbZN+
	ClYmo6d0fh6tRwSzmYW9yVk9EHxAPfqSvBq2LokzbMmqGCJ/rQfUzteKaoUJ1gCJRll76E45bnZ
	91B8xv7m6jtl/wSTlMzkhFESw2k6BHCjplXJaWWWYc4SEAWCChE4nT4fVzcXvwByn08qIPYxg7j
	g6g1k1SQft7m71+xFU5yhCdAt1QccMTlV0fd8jVtVxDdQ=
X-Received: by 2002:a05:6000:4b13:b0:47f:9629:b897 with SMTP id ffacd0b85a97d-47fafa7895dmr293725f8f.49.1785176348234;
        Mon, 27 Jul 2026 11:19:08 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm51042855f8f.23.2026.07.27.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:19:07 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: openvswitch: fix skb leak on flow key update failure during ct
Date: Mon, 27 Jul 2026 20:18:31 +0200
Message-ID: <20260727181851.306076-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727181851.306076-1-i.maximets@ovn.org>
References: <20260727181851.306076-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_ct_execute() always steals or frees the skb on failure while
ovs_flow_key_update() does not.  So, if it fails and we return right
away, the skb ends up leaked.

Fix that by breaking instead and letting the common error handling
code at the bottom of the loop to free the skb properly.

This is a very unlikely scenario as it requires the packet to become
unparseable by applying a set of actions on a previously parseable skb,
but should be fixed nevertheless.

Reported by Sashiko.

Fixes: ec0d043d05e6 ("openvswitch: Ensure flow is valid before executing ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 5653b6642e10..0500939cc8d8 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1380,7 +1380,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			if (!is_flow_key_valid(key)) {
 				err = ovs_flow_key_update(skb, key);
 				if (err)
-					return err;
+					break;
 			}
 
 			err = ovs_ct_execute(ovs_dp_get_net(dp), skb, key,
-- 
2.55.0

