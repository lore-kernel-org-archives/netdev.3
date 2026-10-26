Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034745;
	b=BgF6fnN4ih3rm6oABAwiITvn0AyPJof8YZcjXy108wnUNIdXdUt993Lnef14d6iv7CEW
	 CVprvmiGi61uYWcsFW72n9AFy2UtWv0YRafFU39oYwL5dUobpg5VuQU1k98ceVe/TFj/1
	 N+wWkVJXXPuIa6dl6HPGYU81wHRHP9l6h3YcO3C7ahyLSMQwrjWRVYJTavWMs6HBXo2SI
	 Lb5kImMjHkTnlXb9zguzQBu2lQxzzLiVnNZmyuyLgRNxl5nJ4WlL3b2fF59SFfBnRdAs3
	 olWVm0xlmVLoqAiF+LraEt/KWzDxQ1H2WtttsG09UOtJQQeGHYuj8XZ1TGpLZ9tNclw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iOoWEuPN8PjFnVXTaFSVmZD4apYLmhkxv/+CXdjOZWk=;
	b=wiIv/wFFh0D1Psgo+vHPNVvMR3KY4GKTwSpmLB2d01kZcO/ftkm1KZ/E24VflcUTJdXj
	 TdfRjm5axjuQQyEbc1yArebaXsw95thUDT60daaiwSrH3DKIOMCNSiMkXGLu6s6KUiF7A
	 p8Ngf+ZhFObBSYDx/Pc38GeiNCYdS1VrcmKYI8I/7JFB80F76jQeqymQcKxiEbdy7ynN1
	 1s4CfKlCLc8w9f2UY7ewh9WYuQQHPVRuvr04+T53pfSbSq3rxsMwMyPLgtVDQKn7AGSKV
	 P3NI+aJOuZxP0uLjPYyarM9F0hOlRcB87a6qzvOOsSszOAk4NDwkuU6O/2yFspCPAbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=byAEJTzM;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC060A2608
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEC060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=byAEJTzM
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso9512197eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793034745; x=1793639545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOoWEuPN8PjFnVXTaFSVmZD4apYLmhkxv/+CXdjOZWk=;
        b=byAEJTzM5h3m3pLs9kOLClXB4NK0e6CQybHiG3+TjFRtHyzUb3K68VWa5AHmyQdhsF
         jncHkDdouVXXW9VDmMqC/9nXvk1uzbZce/nZ2KY8e4pRXeYWHd1A0gfZa6/pSM+OlX4o
         3VKAi7j/p+RTSXR0hNpw1TuCVlCSK1ExEy4INfLTuYm12YpNdS5oeveQYd8oDhcxiOcA
         /oituPNmc7JAw0NMDBJouk6GgWvoqr7QmQi3ph9m+4aXlMhTsA/nrmyVAdN9r7/nifq2
         ewhSACOKiL2Y5/KTGRg2qvEE7PXxWePB3mkSQj0E+bQuusYQspjqft8kRWZQ/+vGnkqu
         VIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793034745; x=1793639545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOoWEuPN8PjFnVXTaFSVmZD4apYLmhkxv/+CXdjOZWk=;
        b=z4zaxwFkH2InIOAwSD09T4kaKJs2T7B0cDn3chWs58VVSaTFHR7vrQc9aw7h0DHD9Y
         qL1aJsKoIVtVYxUeia6ylBD903J6k9osYP+AGUoyek0/r8N8+hXDdl/rzxpgpzzLIIit
         hKMGmF7Alry7kQahzsJtcoXPuqWFPqSXzy7DFz5uMcy2vqvHM6R4+Ey2iUEBMo5Snjml
         GRt0xX22B6kx2LvDu8p7uJV1ASWtKsclMfsrzmoGAmizIXMe73S770GZcIHfQ3SGOYba
         r+Kp+9GZNnDDSfPRKtSDLNBHR0kVlMDVv0wnRhzYu6H8F0NXxP+VQBeRH/Gmq+Z/hzBe
         BH1Q==
X-Gm-Message-State: AFq9FYJTrR34FmIvckVyKA5o4ORW4Tc0APw01xK6oO8csUy1Tgx28Nem
	nZxE9GxH6A4MC5bgJIZJrWnfMTDfz8fsPRRbrx0MqMensecgtz+YXKF/J5Zrhz/V
X-Gm-Gg: AYBFou1T94smVjtXnAad8cWKeFhnBs/rDtaNMjJ2PaxSwSYu5Lm1bzsS4MkASqUS6lP
	sxpMp3ELyB/4PK7jk8HBiMaThIUE1AyGqFMSi+drgtRKKwtnLdeG2LjTUYGLeFVQJcf+Vw+XdMR
	14XTFHiyKVok0O4oPQapY8DiqZkmOJWavvYvFplUZx1FwxU3WOoRNLzkuXYIEYQCQZfESGIgLQo
	EVWE9ksk/DU4AiFuNkLmlHg7OvCdWu39geZfsARYGJwqr6FLlH0TAVCmI9IWeKfGSiAvURfpd8A
	BQmli+B5Li+GnV+TRcGjgNLi/MdcaEU2eSm70YKuSsxEuC6gxb1YGsqfN94yyBEpdAMfIkN1QsK
	NL50AzATiyN0mJ5C7T2rv8O2EpXLUZHZ0/Hw4IQfwJiAF4x9CrtbZERUIV9U3MOFJltXUou57dp
	WZ6v7D2mEykHgi96uVGxJwrgyl9LqyWroSUB3+6Fjdzm9cFFIF7YcIpJIWMZY/e5Jj9AUuPQ4uy
	a5gTJrCXWjYlec8/GzAiRg5aL/cpz+q5jNCjUUK6t/btHqYJNrR30mUGad9xE+F1POaq/bnWlI3
	H2l/VzLZzhEc6xjl/82xAUMKZSUu9CEYIHSl3HRies6khpFpTjZv3Hk=
X-Received: by 2002:a05:7300:2301:b0:347:8d01:164f with SMTP id 5a478bee46e88-369e84b15ccmr17584028eec.19.1793034744342;
        Mon, 26 Oct 2026 10:12:24 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm24878750eec.4.2026.10.26.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:12:22 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/2] net: dsa: mv88e6xxx: fix 88E6171 statistics type
Date: Mon, 26 Oct 2026 09:47:33 -0700
Message-ID: <20261026164733.737299-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026164733.737299-1-f.fainelli@gmail.com>
References: <20261026164733.737299-1-f.fainelli@gmail.com>
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

The 88E6171 uses the 6095 statistics operations, which advertise and name
BANK0 and PORT counters. Its stats_type bitmap instead selects BANK0 and
BANK1. Since statistics collection started using that bitmap, it has
written a different set of counters from the one advertised to ethtool.

For this chip, get_sset_count() accounts for 30 BANK0 counters, three
PORT counters and five ATU/VTU counters. Collection instead writes 30
BANK0 counters, 26 BANK1 counters and five ATU/VTU counters: 61 entries
rather than the advertised 38. This mislabels the tail of the returned
statistics and writes past the advertised statistics buffer.

Select BANK0 and PORT counters to match the chip's statistics operations
and restore the filter used before the bitmap was introduced. Tested on
an EA4500, where the two-bridge forwarding and multicast snooping tests
now pass their hardware counter checks.

Fixes: 5595e3613ea7 ("dsa: mv88e6xxx: Move available stats into info structure")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 675b82857754..dbc4a6be54fd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5960,7 +5960,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
-		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
-- 
2.53.0

