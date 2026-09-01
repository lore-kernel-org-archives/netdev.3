Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDF371887
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280458; cv=none; b=HWDROed0WDv6RXACwvdxEcTCXkR8GlxawQInSLQIahU6vB4OB+9pImEwQ1yQ1xVCm980o2shbkHleNsRoLwQHe5CT1LLdWsAqUghFQF1EZsS5LV2MJXulFUhLLkd7f4DJABPM8cD8f0Ieflb7J1CFBwdXDRruW4RinR9eRH/5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280458; c=relaxed/simple;
	bh=eQ+b0FuUbkgk3GjbjUprpVwWlSOMhpS2zwmbdYuf/ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCJQNwyLipS6OBzGA+dNn754rNHmhDnk/dExSeh+qhtchBOjNktA2HHyG7t44bUfTqh+Wzw1NI82Z3Yn2WNw/gbKxjDoOYPeFqmgTO8/6MsR6PQwmM73FXFIpMWp8kokmOp0zFvX6Pb8QJFEvAy3KhlVoVdMSbVYRW4K5T9R/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/P4F2lD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/P4F2lD"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39da69c5ba3so103041fa.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280455; x=1788885255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQ+b0FuUbkgk3GjbjUprpVwWlSOMhpS2zwmbdYuf/ow=;
        b=i/P4F2lD2dVhRH03OWaNIxcaZ0qGEbhnQcHJ/PA0eeuxUfggZOr0UCwJgbPfYmo5FG
         IiJW4Pmx9tc/y+hECvKmvSN0uL+kuQL+1Eoyij6kFyGagr/U5RsxL2vZzOVg4C6u1Fz8
         C2fOwaphgDK1ABS3Hm6hzs2dcIel6fcMEs5RvPPksS53j7fDpgdEQpC1cTHhEIr4C0EM
         ljSo5frBBJka6EfgWMhhq//O15I70mO0ZJ5IMLgRYdpPrcEj/OgYnaK+xWez0fquckMc
         9dPAHpmmMLtWlSkQbsYZcpPLu2RZCrDrsMt1UauGorSPAYTvcVDQ+NvjbzX6eaNhlApT
         JWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280455; x=1788885255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQ+b0FuUbkgk3GjbjUprpVwWlSOMhpS2zwmbdYuf/ow=;
        b=MoFUbxWAP7KVIaFENp6LiKsL/vw7jTaBRztQb/nICbD5eOMXOBmpnJS2alK4+tX9ug
         cTk2Ir6ctunc1RLNu1XFtSb/LdIkGpeTBw1bkuIvHwK9c2wN8AKhfzozBi2y/hJmIH0w
         JwugocjuYUuXsDY4EAR2K+AQqiCDxkM85VfHziHDwC9vffV85Npu9qaTL1BUpLHR731X
         2hz6UOVR8P26jmprREHIO1uk5xxNVWfuQEzBNfgM/zyPWa97OisBlsaiDL4WHpnzYqMs
         EI9Qj458UvzRSJGn5RA2ffiXjSzPuZc+wQHmIpraO40gQcJTvimlVhT3mFYRZUbmk7wW
         sKPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx16vklkF9jMftbFZjkBneWkm4r3rvOLOi3wPHzZGdM5rMQTakXy1x/iJuJfiY3jH3lLMrNL2w=@vger.kernel.org
X-Gm-Message-State: AFuF++kEIOMorEXZ2oKUlgGPjv9RedNwDGNBrIxaP+dOIq57oRfPv0YB
	8QfwQcEJ9VhInJc/6p1Dfv871rMOBWgmGbGSTJKg8X8Tu0CwC3PKf90=
X-Gm-Gg: AYBFou1ApdC8SMSazWuNHdwoJpZ4zbFfvKbg7ngbjRCg2bnoU5rnCEHpUX63ZvvZ8Ru
	A9OZlVT8fGON2HS6F2dWR0ytvFTNYnegXNDnJbUXWMRCsNFagWOmtCGQFaEX0P5uNpacAacdGXo
	F5CU1kZKIN/yfaWbPV9GLiV5z+EAM6/Spx03J74b+5hPt/Ox8IFiieZkkEQD2lybtIOPhTHv2iq
	j1kWicb8n0iazinohNuVIm/qhqITBbIQp6+KDCbswiAxdOKBjWMlse41DLmLM2MGR8jd6VlTMBK
	JGpL6cA9eq47KU+nXd0gdL7kktd9N6ljwW9CCbeH+VdxYvGykH+8OH5+D3PpUP+/UCWSvaOzqxE
	dkr1UwG8bUcb1Utl+oPYxfhK60oMcHP10od8yFs4FAvlbjXqT4XQxThP/2EYZCBYXCsgq4618g3
	YssC7Buaaeh/3/QBu6oxNpd3/nTwp2RO4yK3KeekHQsXBs4WN99QPI
X-Received: by 2002:a2e:a554:0:b0:3a2:fd1:8a8 with SMTP id 38308e7fff4ca-3a3018ba808mr78554981fa.1.1788280454464;
        Tue, 01 Sep 2026 09:34:14 -0700 (PDT)
Received: from fedora ([92.36.3.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a34a8f03fasm688001fa.9.2026.09.01.09.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:34:14 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: Re: [PATCH net v2 2/3] net: airoha: recover RX ring after hw completion stall
Date: Tue,  1 Sep 2026 19:33:48 +0100
Message-ID: <20260901183348.40949-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apaA5jDYH71F0JaS@lore-desk>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com> <20260831234701.206021-1-sochnev.v.74@gmail.com> <20260831234701.206021-3-sochnev.v.74@gmail.com> <apaA5jDYH71F0JaS@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> IIUC increasing the ring size the issue never occurs again (correct?). If so, I
> would drop this patch for the moment and add it if it is really necessary.

Correct. At 128 the stall never occurred: 500 forced PPPoE reconnects
over 20 h, ~37500 samples, zero triggers, plus ~994 cycles in earlier
runs. This detector was compiled in and armed throughout, so that is a
measured absence, not just the absence of a visible symptom.

It is also not sufficient on its own: at 16 descriptors the recovery
fires roughly every 35 s and PPPoE still never completes, since each
recovery flushes the ring and negotiation restarts. The ring size is
what fixes the bug - and the other two patches on their own are what
ran the longest here: 508 forced reconnects over 20 h 32 min, zero
rx_dropped/rx_errors across 39158 samples.

Dropped in v3, just sent. I will resend this one with evidence if the
stall ever turns up at the larger ring.

Thanks for the review.

Vitaliy
