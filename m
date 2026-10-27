Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136312;
	b=WESaYI7DADI8shzQGJFFjX97oQwb/WqyEr9YnfInxFQBNNfQIrGEIk2MCwPFeOH/1yGC
	 7nazAE+c+94AsG6F1bVkwg2yXE9fhS895PMFjnIqJ58WXwifFHh92EtzEA5ohWynqgxIb
	 7Wt+lPkL4s4WZymyRK4KyAt3PAdWQgExHHikWyzn1qc1dzq3tDpEIehlzGHE+yDGhx3nH
	 DbtWTOwWX+QuHRQedLOuB0gl25oBMAQ1mXlR83UvPkzyeTntZkaD8t2z4WIVO/X+oZeqh
	 FXTHpOzGv7TD6f1X+ScBPKN88DWHu5hHSEofJLvBtdSn+owDwu3f3Q76UhtryKX4GsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FF5WnnOMO3EPNW7Tu8nfwZQBRS3X57+RVAxmjEP9KT4=;
	b=pfs/0FPioDFiGumgfrChc+gowKdqy010r9ZB++WGsKY2qj/9Lu/ZX5igTBnaNMH517Yq
	 bP3xgNKhCetd1zfLulLVssvq3H8SOS7edetcqz0CA/Qf0vroUz0zB7yPpL8uimSuEMj2K
	 f8UDBc/Ogo6RwTyRtZjSYKlYsG8YWQodBaznioilEiEgIss2z3nXGsz3T/7WWhUiME0fc
	 mL/lMFpo7vHAZwRX5uw3giOfeDN2hisQ0KINnlcXCwTVSrl2EhfELhvvYjQxYBXc7aQBe
	 hCSFmR3G2m4JWskEpSCkGaCwopNR1CAtFI9IzLDi8qrmYBj3mMzvZW52C5IX/f3pwWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDgMYkdC;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A853606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A853606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDgMYkdC
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c37b612635bso36084966b.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136310; x=1793741110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FF5WnnOMO3EPNW7Tu8nfwZQBRS3X57+RVAxmjEP9KT4=;
        b=jDgMYkdCZ0/aX/InBd/FYxPslr+3Q4rInRUJRjGR8BMFCa4dmOhpdLhhxJr1bohyat
         NlnazmJYNdbc0RPHgqjdNeUhUiGrRHZPk44EqqzfHcc/M6uMaON8CnemrF8M+ZiTDewZ
         xNvG9+1kYjA99CINrHh3/3NyTxENQ9nYmaZBZF9BiKdll/h2eIQJiceeGtSl+ogjQNZ5
         /M08jVEfHN72r1mWPRx9ZpJNv2zwPpCho/ui4MAu4/of/UtWmKYndjWH68F9jtsPmZSY
         3OCj2YPRvV0BPYYtnTDTZnYDL8DEWw9K+SJBhjSWrXP7dkdp7anmqST6R8lHi8f5KXWX
         2UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136310; x=1793741110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FF5WnnOMO3EPNW7Tu8nfwZQBRS3X57+RVAxmjEP9KT4=;
        b=soOxol/XCidaPY4Fl6frdEuH4Bj2EcfWbACIAuiUbGaxWNnp5FLizkk3mekUr+o+Kb
         jGMP8kLeb+E2yx5w/a6NFeNOPmM84A0/f6TVHRx5DA8hoYzUf2zwCFEIQtCvt5FOhWLv
         jmkNPzIEPT7KRS3A99/q/4nMl3LvWMaTitdSaLhyur3nS8uL7woX3gOmQGOpcPtuNfQ5
         T4SmcLe1O3JQJuWaUoA7d8sRg4WnQGZIfQr57kDJbWFRLXQ7PzAlNRgFGtwhrp2xEJG1
         cXw8dY59Q8cL/SqSbsSF/4Co4aMggnnQq+xUKHXcEyJEHdYWF96WzbS8UPhsxN9J88FX
         LU2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwIkYBsaX/Xxf/9L87BWZfwr2IQ5P/FWy4sM3UwHI1+/DvqoS1QWpVlJ84sgtKt+32PJKpcNW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVjseG6yxnadNaEsAV2nbtaFx+d6b1xT3Upi2dMk3eqIgHs1sJ
	dHSzoK7r6v7SSBjJB+jL4+yMCZJwP8jbLQQjPTMP3k1CXOi/u1cxTrQx
X-Gm-Gg: AYBFou1VHjr9kzgCMB4a/ZyW/+etcmGj/PgW9UAamm3fkAb9EWeqkb/o+D/Djs4QGkS
	T6Gwa75Gx2IUP/ztuDddE3XkFMMlHpktrmWfDJ61wCyQA3Xfbb9hy8cPnSqhNitg2ZpIrT2ug8F
	1DOIUXx8vEeYL2KFUDqdy9BCw+feK5UGLUlrVqcySxa7kxA+qNkkdriF70n2MltH62jmKjVtQsl
	XRSEfUWTN3egUDmdD/f4zsAznwZLNPN1Qv3tmxcHVoCbNnBtyPELxb5bJPiGimqSY5ZHnumgGuC
	6yGx0D7jQ3WL0MfZKtpSWNMmpPWEh9fJlg6W2fl6ZiCroRRcf/AFW6xxCxZReF3tFlkIWhzzee7
	P2rPyNSO69ixwF72tGW3TiPNiXwor1YCtRUav29zOA7S9EDEuGi3WXzqqxFGrCngZRpUP1cPajt
	G/jwh0rXJVk98d8nmkx+is1owRtpC27X3QdOZvqzVBAMQOZa8+kAN71ymoPBwuey9ApVo1wqUkO
	1LxW7Iv+GfwAeh0LKVe/+GYv80R6O07e7c9AOSZUrNEZxRDAXPKrVGhBT/SwNEcQG87g5+emten
	+0z386vcP5AwdHUMKDSZGTo2X8UupoiPVJfaEgy9dLxyZEcaNEGy8nkiie7j
X-Received: by 2002:a17:907:94c2:b0:c40:eb1a:4c8b with SMTP id a640c23a62f3a-c49bdf77980mr40681866b.29.1793136310349;
        Tue, 27 Oct 2026 14:25:10 -0700 (PDT)
Received: from CCM-PC (83-233-221-133.cust.bredband2.com. [83.233.221.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd350b52sm513224766b.7.2026.10.27.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:25:09 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: Re: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU changes
Date: Tue, 27 Oct 2026 22:25:05 +0100
Message-ID: <20261027212505.1848-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <47e9713f-815e-4caf-8928-a7ec12d0087b@lunn.ch>
References: <20261022155837.760-1-yongzhao.derek@gmail.com> <179268501671.3290.6623232109527554630@kernel.org> <20261027092718.266370-1-yongzhao.derek@gmail.com> <47e9713f-815e-4caf-8928-a7ec12d0087b@lunn.ch>
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

Hi Andrew,

On Tue, Oct 27, 2026 at 01:54:16PM +0100, Andrew Lunn wrote:
> Is this a real problem which bothers somebody? If it has not been seen
> in production, it sounds like it does not bother anybody. So net-next.

It has not been seen in production. Following your suggestion, I will
move it to net-next.

v7 needs another revision anyway. Sashiko's review [1] is right: a
concurrent PORT_STATUS reader such as the PCS poll can corrupt the MTU
snapshot, because the qca8k regmap is created with disable_locking and
shares its work_buf. Clearing the MAC bits unconditionally would not be
enough, since the restore uses the same snapshot and the MAX_FRAME_SIZE
write also goes through work_buf. Stanislaw's patch [2] enables the
regmap lock. With it, the v7 code passes a local KUnit test that forces
this interleaving against the real regmap core.

I will send v8 for net-next once it reopens and [2] is in net-next, and
say in the commit message how the problem was found, as sinfo asked.

[1] https://lore.kernel.org/netdev/179303171241.3134.15019965307136674652@kernel.org/
[2] https://lore.kernel.org/netdev/20261022192933.384898-2-kuncy7@gmail.com/

pw-bot: cr
