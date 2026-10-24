Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866090;
	b=DcnsDLN53eBU5NBNiPJjewnJEL2RBQ1sem5m6iC63xZoyqNLQvnjmjUKh11PKWDgvtR8
	 PhP5T+ogFOA3xm3VWwaW29bOQ0LMGCj3B5KvxIcLv4lpWkoVIFbvNBffLwVeAG7/gL7DG
	 oDiOcZP7OqrlIjklbceficTfJopsNWJBwWGdBkxZ8OXOVD7pHlhk3O3/1GiWEXiFEv7s+
	 IlncEvVW6bowXvg4YlCBeI6YeFJNbQTlvnKxMnsUnk1iqMSJmHWNQNzWhVJwQ3pklJtem
	 EeMdqGIXRo9JHwxH4wTWJz+gj++ht8D0danVftd/wQ5QKnAvc2Mmfoy9o5AbaLanWxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CrjR2yr02sD1WpQZ29SF1jsEFlUfRLoiaxFwmlPUrwk=;
	b=OJ95X9304nTDGe4aizEdl4ENOWfsK9mnU0dR4gG3AAQxl/tE2B/b9SYuxa/UwvlzAS4+
	 8o3vdz4P33g4oJ+ZjlnZ2BE/rgJr7EMeG0wNcWjBixrJ7cMnL/QwLDR6vZX7jf74PB9bs
	 n02un1I1hllVGBUbC6lMd6bR6wIVE6zYZNp5RqB7yyJ7ot+lhkWf+OC/CwskGT+nItew5
	 njaadPoBMqPBVHD5JpICqV2GhIML/260FNOEXFYYdJ80y3lWWVx8aybGqmQM6C/tBCK0N
	 yx2q1ovrC0DYiTFrdR3UvDKRWX/u6DdKIuRmrNI+QxfMZGHwWBWK+hUWf50arLQjk4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g4URQ+H7;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCA606A329
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DBCA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g4URQ+H7
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36661f953e4so3353056eec.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866089; x=1793470889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrjR2yr02sD1WpQZ29SF1jsEFlUfRLoiaxFwmlPUrwk=;
        b=g4URQ+H7F+BveIsuaNM4iDRcC4vAOwnINJwL4pvH0DAcYVoSi98Hu+7xvTNk2feTVo
         PEAqLTZgI8BDe+ZBa4cBlHR8Tn9+vdgT7t2QknjAEU2v8fdD6r7t10yUjJlHY/5PNuHl
         kPzDQXAf9pPV6aZEOWx7sj7faBw8wCLTDZ4dghALO+uUepoADfINxZn9o/ixwAdEpMhd
         Wp0cb4kUjPCSG673eIDRr6CAjUTkG+ONJdMjwZEjtC/JezxYBRDtzoex1XRr9qTZ1pm0
         Km/TuN2xOZTdfZnARQdoCP+bvAOcFY5ng4tquD15CRweYtT7LhYMwZqktcA/RshD3dSN
         pnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866089; x=1793470889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CrjR2yr02sD1WpQZ29SF1jsEFlUfRLoiaxFwmlPUrwk=;
        b=FI85cK99GX7JZSG2hMy7Ua82SU8gNA79x4oi3kMR46UqJFux4+LhOyPOSFmwdYt9aN
         4sxlHiiA5AYR5YifkGx1s15Q/B4ljluMkHajfV6iszQYmnQyLSakzRktkPSJt9GFdwK0
         irO4ZNR1uCQSZaQxymnTkBKFXuTFDKFL9SLtU0c3twz8MaXyuZEoUc5GrR/BezCiQPnI
         hKRYhyOre0+VOnTapJAJBDr/fTevpEFMC6KKjvtDV7bk2zSrHQ+8sTAEFIexNWzrnfhf
         Iy7x1TyQOJ74+et8StdGO+SNAfdvPRv935X8W7COJP4VcsZmTCw6FMNHhF8k4mmRieEB
         b8og==
X-Gm-Message-State: AFq9FYJHURig6aMfmdqWsJ0CINNmjxKbbP7PCOVkLhwPpkIMQmrzOUOB
	ph7DtHaFhk6KJSZ1UtBCR+rTHiijE3liblO1ZL0yuo4AmXN0M12VMH4xzBq5EWQ7
X-Gm-Gg: AYBFou2IKgmF7deZyl76ylr5gvAfDlqhWou5EEuc76DVeYHV/CzskwgnibW1HW5EDuP
	2mohvr8UZKX3ntTvtvS2Qv4QWtEyJP/U1BZccUo6UPegVYP0R8b0NR6XuuPWXX4wVLTi4DjQZ+v
	QabjmaeYDA8OpJkxtXq6oHzviKB4ydK53u/FR3rfNVrGljdGHMZLpPYw0jfRStx1TTUV4s0Xgyw
	VkIznoB73A9z96OfAUJlS336JO7zkkNbgkb7iXlH3mFVcX7d8ENkgN7bWDeAikCTzMkz9XoyMB6
	D5IcgTswhySswLq13fw3ukF+TP7HfEaZMohHGNm5h+JyJc/LnRyMVtwuIiAHqZEblh3W7HbChIG
	PjR+lUS2AeA2crACnTVuxFIN8hqxt2RKvJXwdfhnD+4h/ZAhldzEeQdKkkw7YUp2gLcAT1Kj5Rb
	/S5nIIsAC6XedGO+pa3io3PaK3zEH/WEBN9xWw1Nr29h1e7w8R+k5Sfau4CXyARmb4cOoiuGPhi
	nxyFGXGiPYUOOIgGV0Z/SWhfy4y5ZpC7FtSV/wKoWzB98XrzC18ceiOOxczL7GbxDuarw0vQ2xp
	i+edVyw=
X-Received: by 2002:a05:7022:2088:b0:148:722b:7cbc with SMTP id a92af1059eb24-1993505df6fmr3235936c88.14.1792866088809;
        Sat, 24 Oct 2026 11:21:28 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm8174893c88.21.2026.10.24.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:21:28 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 1/2] net: dsa: mv88e6xxx: fix 88E6171 statistics snapshot
Date: Sat, 24 Oct 2026 11:21:23 -0700
Message-ID: <20261024182124.296988-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024182124.296988-1-f.fainelli@gmail.com>
References: <20261024182124.296988-1-f.fainelli@gmail.com>
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

The 88E6171 belongs to the 6351 family and takes the port number in the
low bits of the statistics operation register. The 6320 snapshot helper
instead encodes the port as (port + 1) << 5. On an EA4500, this causes
ethtool -S to return physical port 0's MIB counters for every user port.
Traffic on other ports does not update their reported hardware counters.

Before the snapshot operation was moved into the chip operations, only
the 6320 and 6352 families used the shifted encoding. The refactoring
incorrectly assigned that encoding to the 88E6171 as well.

Use the unshifted snapshot helper for the 88E6171. Tested on an EA4500:
pings through different switch ports now update only the corresponding
port's hardware counters.

Fixes: a605a0fe7115 ("net: dsa: mv88e6xxx: Abstract stats_snapshot into ops structure")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7f68a0c55802..67daf3b9cb48 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4610,7 +4610,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
 	.port_get_cmode = mv88e6352_port_get_cmode,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
-	.stats_snapshot = mv88e6320_g1_stats_snapshot,
+	.stats_snapshot = mv88e6xxx_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-- 
2.53.0

