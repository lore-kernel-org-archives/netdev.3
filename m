Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134449;
	b=BINCo+mpRlcQL4I2+TYa6VbEGeKLrx4smmquWHsGAYo/ewZf4tQMVAA7/6bzAAVpckCo
	 4HPzdzbMk/OFyFoklmLes+lH78cO2EViRBjG68J/YLeeuGOwkQ71QwzTqnWD9RqSlwzXu
	 wc8hQQoebeWQXRgQUs660lgC+AcK/r1VxukDks97daUoJtrl2+7wVlgOEfFozpcaDLbaR
	 BHwKY8mhJxikj46KY/wpTHPU5PgLoNo+yRlT0jpUyvkMcPXN8tA6TVN4LjxRgQrAnHzAz
	 J4o5aGCB+27yONvM4TzirVNA71DBkMlbTKcU4pbhfritW11KW6ONgJNDTKGsitBZ+yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hI5wV3V3vozZi1HhdmXT2xHjqsg5h5x/8DZnssR+H1s=;
	b=j+mMYFhI7uN06KeRBM9XIE+RjRA13us/SmecY9OK3M45NMifkTDRR3ppjEpgrbXuA6vo
	 QQKc7BCwQYbOC4SP0lIMMncReNjd7QpgM4xdGAuLwfFeOD+jnfG5crdGx79Trwdv4FfXa
	 oThpsDiakzyKnmSbIeuCRDX4hotCvolbmFtDuVzngzKXrV4JxCtXlSQea8LeK+X+qPmHF
	 jAWvF5YySRL0pJQlGe0yv4yPvNLKw2oE5cLwzksbE6a7mYafrbhiY+jC9UAeSFOl56Kx9
	 2O7pYrNR192sAJtf0tfx6DzCAKiVNNhuA3t1ThfzyOPJc4unmq29BTSffrMJFeeGLmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohRQ6iJ4;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A2606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 10:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E4A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohRQ6iJ4
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so10398a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794134448; x=1794739248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hI5wV3V3vozZi1HhdmXT2xHjqsg5h5x/8DZnssR+H1s=;
        b=ohRQ6iJ4wbszgq2IRy/MehqSnwaeFCGJcF8qB3YBq8L+Rk6WX3Z0ze1I72w+yJiOX9
         FYdYUqwC77dnyzTN5SLpoe94OZ04uDevu4LSD5gJJJL08Vx8GfKmTpzKt85XFZEGEF6g
         G8HClXK9XXE9vio8uhQWbmM9f1h1XAnGJNEP5AquHJF/btblvrIcmMqMe8uK1PyyWvuB
         MRQjxJSM7aVWixSaVgSXHPeSBf3qRVCHATxy9GjmwOqwKijYtKj69EW2RB8hWqFkebY4
         i3FWoSqau00UEafFQH0Qan+j2SGs0rbTow+ULzA8m2s4W5PTJJdQ1GDNv2DJXxogfH/u
         wdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794134448; x=1794739248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hI5wV3V3vozZi1HhdmXT2xHjqsg5h5x/8DZnssR+H1s=;
        b=RiZGE7CAZgalUxHFM5pFSL2Kc+zxM0osxVnk/9HvqwohAbF/li6ifHfq4eRqxLi2ZB
         Go9vzud0O2PTJM6XSv68s3DhSt5E6Kni5Yx5h2JRHyJ8G6D77qteQYuVoJm+IxM/jCSV
         o4q6359SV19n6cQnGr4azmib8agaYcELaq9YJlKPenasywFhrzC9718a/jkD78QRPQ0q
         mAWF8fbG7FhGBEW0gVSfFCFk6eguqrWr4c8PevIndVadpnxyDpqBhLacnyGzgFa/hP1u
         IP9XbnVey2MWBa8rB+5BHrZ5V0yUP4xYbAvJr+aJ5hiSEk80a2HMUWplFaK2qQHTXBWn
         i7Nw==
X-Gm-Message-State: APuU4Z/irodvWt6rQjyMNHA6V47UJdF1hl9f1AnWku+uC+Jl2/rDWotk
	JAaFc6nfrewy30PqIN0IxelwA2GDRBuTeJhJWMKpL2LtkoCjhWKT7dDnruPsYQ==
X-Gm-Gg: AYBFou06RvXBzrqE4dFtEM3ouEYGrG3a1H35qTIi2dES5oZIPGehmPEJkLX4sHDhtvL
	gv0UK8NDoY/WG84YtK6sO54turpx2I3n/NKPH2RfgyRf9IXdd6oI5wrEQX2GbBpqlUJ4+EnuGld
	4Fzv1Py1C0aijSI9MHyCdw4GLC4FzC4MFovTgps0XaRnDw+cS9khtz7ZD7rkSZqBcgLMRtyi13L
	Woj+fBWGZBW+207FcrOqiZs08JIkl/tBicG5ppjOuptwECA2REziayfHw6NtzOxnNhW/HAhEXWy
	5VTIoBabZzjnOxQ1cbcgXW242KeFsY5xnJjc6TYS3zZEJxGOAv8B39gb9Us4wKag7xKxIJspVPN
	XyazFojaRt3xYLWbzfGdChy7YmQeX8iUkMxNP79JpFxt8MPiZkRiw3rwYVNS2DHeVHNKTFZXXGn
	jRkhOmB6Y4n10n3XFBle7wTiyHE9VqSTiqv3dMC27NK+GLK/mfXMwHwQysysq0g0QI1JQKwVPGR
	cNMNH85SktUR45kRjqn2VoCVqnSikUa10gx5Yab2+Cl/Cme2zNsMJPkRimpb+FJFPfBjllO2F0r
	VVlt0lMiaQzC3K9wFa7dGwVNroy/0Vacc0/UT1N1f0syjVC5ybDlPg==
X-Received: by 2002:a17:90b:578e:b0:3a4:9dd7:296f with SMTP id 98e67ed59e1d1-3b12d388298mr932987a91.40.1794134448311;
        Sun, 08 Nov 2026 02:40:48 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1032c4508sm3724945a91.2.2026.11.08.02.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 02:40:47 -0800 (PST)
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
Subject: [PATCH net-next] net: dsa: motorcomm: Stop MIB poll on link down
Date: Sun,  8 Nov 2026 18:40:34 +0800
Message-ID: <20261108104037.1320166-1-mmyangfl@gmail.com>
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

The poll re-arms itself unconditionally, and link down only cancels the
work non-sync, so a poll caught running kept polling every few seconds
while the link was down.

Cancel the work synchronously so that the re-arm from a running poll is
rejected.

Not carrying a fix tag - the existing behavior is harmless nevertheless.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..758599ba0957 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1837,10 +1837,9 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	int port = dp->index;
 	int res;
 
-	/* No need to sync; port control block is hold until device remove */
 	pm = priv->ports[port].mib;
 	if (pm)
-		cancel_delayed_work(&pm->work);
+		cancel_delayed_work_sync(&pm->work);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_down(priv, port);
-- 
2.53.0

