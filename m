Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874348;
	b=27zfwCDkucSh/79n0uRmXuaV54bf3o1nbINgF66Wh/iQ9fVB8/sWZE88Eata7BzaEJYe
	 rNR9y0/8LTBWqN3OeRUJf7nUgakItVkClO5P3+lRf5uT3F/nfMRI5uWqX7S4HQ+xlwfmu
	 h/MjoCwTPuFqH6nR3ubP7vo0kWRDdf2fxTED2aD1qzhOULUI+ngyWSBwhE5kfHxr/Ni5u
	 0tLYSXrenviUu4ZWL5xg6Uwq3WHmhC+nIFvqtcrhcjrQeJrq9vJEKYs5SVTw3RMJphQMT
	 ymOywJNfCoZ2JAyS42At5vjMJnwN2AxP796yFmAXLBdl1RNa3oZvcCeO//rsv56BfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l2bEp5N3wkDM5hvlXu/q4Wh+Pcm/FLJu3KnOMv2gYeU=;
	b=tTzb97EiARBNbYCDrDc+1ki4Om1czNDGDnbqWoTyfrARhWLTHJLNGVCT2yRY4/Fn7I5x
	 bXT7qbM7yrmEn2GoX4esMfp1xWud+YjvHJtNxIQzafvYGPyP+u54xXueewbg6Pjd+6Y9+
	 FlKPvDe5Tu4VGpynPbPgFnVgF6pN1SIjKK33NECAIzGY0zcxRZY/ASoVYpAVx2lB9SOue
	 JWF854j5J5C4NW+QfmrQM+dVrw7I7hkTInOrxNUk6/pn5sXlJpFYcbjV4yVR5xpYFFfHp
	 hzdWrF39AZ1j3Lvl8DDh3VWIC7/G/ZgHC9LM25iugvxscmWR/NfqVUnBipOCoUPJCLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Gg25pHSS;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D5606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63D5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Gg25pHSS
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e977109392so10288565ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793874347; x=1794479147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2bEp5N3wkDM5hvlXu/q4Wh+Pcm/FLJu3KnOMv2gYeU=;
        b=Gg25pHSSDudyY139JVOUsD69eHT7HHezYXjUrUY32x3lKhC8vM78K5hc5RX/Ag6rcL
         Re+BKi+m8a/yoeNc9zo1St5mobFD7sWIi5/iAlD/h5ZaW+fZX+KRMf1Ma7wjQFb0zWyi
         pedUerNElELODu5cAE3jmk/1bg7vr/1GINuFSx6v4DwVBOB/L4IHa3gVxS/I3wrhWzTk
         VoETcKad+y0WNDzTLgy4iJihXafFnnyX4Rz4XXfpSe/qzIcoQJJM4NZZk0LU9qevkiNW
         BAX/78ieS42amsLSPCXVHshWFdvNYX/feNL/E+HOVLOV1DzrPZ/nOEGH9Yvw0vbAOiO5
         QRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874347; x=1794479147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2bEp5N3wkDM5hvlXu/q4Wh+Pcm/FLJu3KnOMv2gYeU=;
        b=n1U/6QxoWpk89pgq2W3Qo04uwc0JNTCSAI7fnyMlpuP9kaq00CWKuz1MloHkQLpwXD
         O8c7JgPKFXMc/+ruMk40EH8tcLCTmBmmxBpBJocI19xi/oAb2YyqAD6Z5TEMlJeB9sn1
         MewbcX76nRSlflasHZljLk5UxiqB/Z8RTqIMs6xYvLGoeG7BnkO5J30S0LSbb+C2eRqq
         J6aQs1eys2O4yP0Jj7LM/tqBYjkb9BJ5k60YrMSOA/816DwZzqo6BsXpU51L/SdDEvFf
         89BEcj/6m+l8Mv3v55FAfaeKMh7b5bbj4jyunqmoGS1JGhwEzqnAbiq7WjcamNBpJ+S+
         CORQ==
X-Forwarded-Encrypted: i=1; AKwUvByJo+9dzXAeaKTy3iW+yYJN3oBoA3tZzZahnha3paqNao0AI8A39J/qSvMLi25+okzfmviZ3ic=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wH28FeYiK7m3F5T89k1lP7VS9q0JcYQM2H/Ohi8zSLkuifg0n
	YTKgMpMWzIVbRs6Nu+FgF0REU8BKwJsLueR5xnCX7xZNfRAB9h3Gmgyer720dDDI0A==
X-Gm-Gg: AYBFou0YA8CyXRk8TCSiG2QG2h8IOrN3TOgCuEOxDYINiGw8/E2wZ89zxFkcrNO+Yzf
	UNov8ZMZHbKNlL6aWDCgfTrL2UwYgklUntCnvatbqghJxRDgxxTDYcrbCxBaSmopTIzeWtFmHPF
	XNhU+F6qe7idmSQVe6ElkLQs9t+C+1KVJ3J+W1G98qm9gLPfCvFqVcagF0U/ZKISQ8DP92jSQW7
	zDrYDPz+FN9MYKvm753aAY/CkFmYWAezDlgsznlVtue9x4PMNR7TeGTeSTJqT5s7sFxOYtBop02
	WgUvJe4cfz8FnmGMn+z3Nr9+JqjDiyHh/jt8WIlxUwcezck+G+Ur3boi6rqx8cR3Eoq/eFC/j6i
	6ceUnLhoeHW/C8Sr3Un8THsYxDJ4HAGK40MD5V0+3968D2de5ZIC8Fw/I2ah3ceJ4fkQCNPFvMW
	kqr9YLEdxuBja3cuUvzU3HBLypBU8Tm9vkfKeY7fwdClJBx/jQSYEtoAZrthOhGoMOwQc7gKI43
	Iw3Fq3CkKrAzh/hFMZWTGbf8i7fUGs20qbErpDGku4orzGLD6LEbklN9e7XhkNp8VMRpL5vm18u
	gCXjBxMe/KwxWsXyElxTUbjMGh8xcCM2T1kjyIviFD5lE9pCKw/lqOy1WIO65oBtlBHjkorDr1/
	AhVFnIKElxjB6woqZ0yI=
X-Received: by 2002:a17:902:dace:b0:2e5:78b1:33fc with SMTP id d9443c01a7336-2eb364835bdmr184698585ad.53.1793874346953;
        Thu, 05 Nov 2026 02:25:46 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed09127cbfsm16133795ad.50.2026.11.05.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:25:46 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
Date: Thu,  5 Nov 2026 17:25:40 +0700
Message-ID: <20261105102540.2273912-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179387332308.488856.2315265262072517836@kernel.org>
References: <20261104052504.1886335-1-jjc@jclark.com> <179387332308.488856.2315265262072517836@kernel.org>
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

On Thu, 05 Nov 2026 10:08:43 +0000, netdev-bot+sashiko@kernel.org wrote:
> The commit message says:
>
>     Only the PTP_EXTTS_REQUEST ioctl still works.
>
> That suggests v1 behaviour is unchanged. Could the commit message
> describe the v1 change explicitly, since the patch is tagged for stable?

Sashiko made the same point on the equivalent am65-cpts fix, which was
applied unchanged as e3aaeebbef56. My reply there applies here too:

https://lore.kernel.org/all/20261022035226.1388675-1-jjc@jclark.com/
