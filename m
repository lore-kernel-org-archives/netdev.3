Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715632;
	b=WgqZdbyDfCJHUt/dOhFlog4fkvAFRzf5Rywm+G9oH5qA2z1OgMO/xcBA7ED/UGq6pNtT
	 SDSDuFE4DFiuMNJ0eMCHFSATEt1OcQXzxQsJQTWFcF1Xa9GudKZswFJk1/sHE67kd+/hc
	 W4RVR01F8qKmNCMAzw2jQoTuTJp5YJQyVM884NJwse4izy/ghu4vvCzkqZ9yEIVkbBmOr
	 yt6dibn0jG2NMDFjOrqTpxubYI23OkQ+s/UH1JDBjKzy+KabNgRJpc617oCgea3K9ZOci
	 VU1C9Wjm+Q7sLqbXgdGeZYznm5TkdlelNhnWeGQdyR2XLHUe8fD/RzOOZV8Tl+BcA/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VpMYzPu6u1D1BTikiHVAhLBIAMWB7XVJJHTCsw6VgIU=;
	b=dlxLG6Xyb02ZZjZJzFRLRhOyRibgIb1nnrCP8NpM1dPypeAyJ4zc5A2NSlprxSW+bGsC
	 qLeOneVhX4RMDqmUa9JltWt/SUjqsVW+du8dvOrQDj4hbKaHLTXKWFUZQIJYoisZpVSrs
	 8xETCme1ycsMF1FAYLUKBZ8l676CZF+Y2NFy+nc0/Dw33Buc5psn9O3CJhVoNCDoWVrCD
	 Gei9yhPR5DfwY8dhWaOxE5UfPv2gdcCMBvaYPL73r3lRHwWIB+6Kbv07fGx26euQBkJXf
	 9rW+ebC6EdobdJkBzbE1p2JGiIIzsHxEV0yAknae98P2CpHyjWt90Jp8Aeyb+z9tHMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chAInqkO;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D856606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D856606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chAInqkO
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab2cb02816so606639a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793715631; x=1794320431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpMYzPu6u1D1BTikiHVAhLBIAMWB7XVJJHTCsw6VgIU=;
        b=chAInqkOHc/Y6EPjxq63RIyXfndpv1NSsFcYqT3l27zg9Y8ezSvmsjanVOTU6y6W5Q
         PLIYQFNv78Gv5TAkN7/tmoXI/i2MrTIMh5f/YAxON5CxJq/TsvgybMbFX/Z3gU/kEpHk
         uu2FUxqYyfTM6v6v+4k1vMCChg7f3WMPHRuTgE7hEyGlJfPc1ezPITLKDETEog1YXsqf
         pMLjbhaGLuM8810Q9Hep0IY6Ow+xJDBsPRHcx0FjJmAzAPfCXNqAlYM3lKArwFQbgbDt
         uNq7U80gsbTcDu9X41K2Yn1de66OuXthsw0xcbmiMRhETKxK/wxPVaHgF7kj3p80pJfe
         U0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715631; x=1794320431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpMYzPu6u1D1BTikiHVAhLBIAMWB7XVJJHTCsw6VgIU=;
        b=hgwPMVb48MR2wFcx7QH2wXNC/lsTHobqLw3FA3J9Z2nBIN5Er7EFwmyRqVgpW6WDeQ
         pE4CVaFjlF6fm0wQc92lmkTMicWiCZI9qQQZ+fIm4ezV40nf6tHQj/RKIn+QCSWGknC7
         qxVusXYMqtM1eFHFg3KOpG5gce7yKoak+50XnyBuqqpDqp+kmBf2BRqUMxz25ebFi84g
         sPZZkPpNkJK27jhH8X5Pf6DXl6oBZHN3vOx2NBC/MwNffM9ZBubnbFeJV9x+aXbPUIYR
         KL6NbqpjvwGJE3qaaKe+aYl1lNHFX7WHZ3FdPGWuxBpkMCl2T41YhMRFh85HHUKAcivu
         NQBw==
X-Gm-Message-State: APuU4Z/n+Pif853NGPAJaZLqN46HyRNwyeEieUpaEOmZk0Cw7Ku3pluv
	LL6TDq3P+iIVvolzse5GdpXX1wtoEBXVqtipRbVSFRj13VG+KQtyzdKhdoUyJw2QPyY=
X-Gm-Gg: AYBFou3eXoR69CQgqKLDyQ0rwCgB00VRBiCUU1GHj3JPEx8ZzhoaScZJGt0P3J1CN9h
	VFDtz54D+HLY71l8NHqMpOXcH5Uch2istQFnMFr0vcSpcK5OW1Pt+cKX3CJQ7Fk4RvfKzgbn4TH
	/lMGBRzjhWWf+YZQXm2Ne/7Me8LdVz1dZXG900noh8ky1WI3+2SU4tL/v7rWw1AbihkrB2IUeZp
	39zsJvl0gNuradXIv6EkflglC0lrrxSjINtGbeemWZnpYQMNR+nIvZQfPYpam/Xzm4jwSKsjtf6
	BJ2/eRGcOoHpnprkmapGQloZHeUfUTJrtffHyd/73ptD8QZh00ZkM6+xo8os2e0QWbLT9CzA0ws
	dGDm1jPNaKkoumcgar+ClLBq72WowGqWNg43zM7V6G+ag69KM6OdIDJZyB3jZ1zEwx2PwO72kVA
	MmNT/IifcTFIxSx3F2B1YVJf1dq66QgklPNB7VDKBNbqjYFTI7GWGalKludk7r6i+4RlVuEjZH0
	YWIrznSLaAMamJ73nW+QWnKt7uHTeOhjlXIJZEZ+AMXdQ3TzBIrhqQ7zQaJbcm98EGWeJW9RsUE
	S1FaN9dNcUr88BKacTqaX6tl/9w3ID3L3UEchfUKZA==
X-Received: by 2002:a17:90b:46:b0:3ad:a84b:df1e with SMTP id 98e67ed59e1d1-3ae895b53cemr18794831a91.1.1793715631347;
        Tue, 03 Nov 2026 06:20:31 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm4536310a91.11.2026.11.03.06.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:20:30 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	horms@kernel.org,
	khc@pm.waw.pl,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH net-next v3 2/2] hdlc_fr: shut down the LMI timer in fr_destroy()
Date: Tue,  3 Nov 2026 22:20:15 +0800
Message-Id: <20261103142015.1588144-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103142015.1588144-1-lui2012qwq@gmail.com>
References: <20261103142015.1588144-1-lui2012qwq@gmail.com>
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

fr_start() arms state(hdlc)->timer when LMI is enabled
(settings.lmi != LMI_NONE).  The only deletion lives in fr_stop(), which
is unreachable on the protocol-detach path: detach_hdlc_protocol() calls
only ->detach() (never ->stop()) and then kfree()s hdlc->state.  FR's
->detach, fr_destroy(), tears down the PVC list but never touches the
timer, so unregistering an up FR device with LMI enabled leaves the timer
armed on top of freed memory; fr_timer() then fires into the dead
frad_state.

Shut the timer down at the top of fr_destroy().  Use
timer_shutdown_sync() so the timer cannot be re-armed afterwards,
matching the CVE-2026-63803 ppp fix (ppp_timer_release()).

Initialize the timer in fr_ioctl() when the protocol is attached and
drop the timer_setup() from fr_start(): attach_hdlc_protocol() uses
kmalloc() (not kzalloc), so state(hdlc)->timer is uninitialized garbage
until the first timer_setup() and fr_destroy() must never run
timer_shutdown_sync() on it.

This bug was found by static analysis and confirmed with a KASAN
reproducer: slab-use-after-free in the timer softirq after rmmod of an
up Frame Relay HDLC device with LMI enabled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: retarget to net-next and drop Cc: stable per maintainer guidance;
    no code change.  v1: https://lore.kernel.org/netdev/
 drivers/net/wan/hdlc_fr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 5f0e54ed1e..2086ff85b5 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -1009,7 +1009,6 @@ static void fr_start(struct net_device *dev)
 		state(hdlc)->txseq = state(hdlc)->rxseq = 0;
 
 		state(hdlc)->dev = dev;
-		timer_setup(&state(hdlc)->timer, fr_timer, 0);
 		/* First poll after 1 s */
 		state(hdlc)->timer.expires = jiffies + HZ;
 		add_timer(&state(hdlc)->timer);
@@ -1153,6 +1152,9 @@ static void fr_destroy(struct net_device *frad)
 	hdlc_device *hdlc = dev_to_hdlc(frad);
 	struct pvc_device *pvc = state(hdlc)->first_pvc;
 
+	/* The LMI timer must not outlive the state being torn down. */
+	timer_shutdown_sync(&state(hdlc)->timer);
+
 	state(hdlc)->first_pvc = NULL; /* All PVCs destroyed */
 	state(hdlc)->dce_pvc_count = 0;
 	state(hdlc)->dce_changed = 1;
@@ -1242,6 +1244,7 @@ static int fr_ioctl(struct net_device *dev, struct if_settings *ifs)
 				return result;
 			state(hdlc)->first_pvc = NULL;
 			state(hdlc)->dce_pvc_count = 0;
+			timer_setup(&state(hdlc)->timer, fr_timer, 0);
 		}
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		dev->type = ARPHRD_FRAD;
-- 
2.25.1

