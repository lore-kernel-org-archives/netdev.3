Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631939A80E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484161; cv=none; b=Ti3oWvRcpQz2lP6YC9fgCIvNGqys5rnuR7vWXJXHAkwOZYD4zCUUg9sbMBaoF7Zk+bNUjcsgGGEdNfGvSuPUxoiQdcls0fgMDgqSr9j87GtSWOPz8wR+SZ3vYpAXoNziVe4fi/rvrK2nbBODLoAuHkdSIH3sYhJRpMJEu4kxToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484161; c=relaxed/simple;
	bh=bS/CRKVVoQdAkaStuerHlYKMhi3opFXvVsPmcBA81Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfn8MAquBwwRCRSS5GiYjUrEpn3RiPnx+XGyBTMRXaDiHB/2C26gvNmmkkSfrZ3G9O+DjaSBzug+apGUw6klu01RGr7BSXcSCs5dNSQa9oEeJA5v+Wkmb1jI227VxAfw570LmeLWO0zxmGR4J33dn77rH9n05B3A7L9vjwG4+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qizLkiWa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qizLkiWa"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4798bea72f9so464570f8f.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785484156; x=1786088956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bS/CRKVVoQdAkaStuerHlYKMhi3opFXvVsPmcBA81Yk=;
        b=qizLkiWagGmgDoYyTiHBpoXcCTYUx1geCpzWbBsiNKf7xI+YGVk8diW73nhHsrDfJn
         0VY44aPFiwpa1uTPXGSQM6x7y0789c03k6dM5gcSMZtNp/fD3KaOUS6Ylb+jCgHcqtNP
         kUhIuZVVeuW0B/yLXjBvOG0ntH59XZiQK6zUTd2zKxS9OxCmZ4N1DuEfnxEBSQuOgEKz
         ifDoTf7eD6FtoPESF4tpCXVPT1t4qsNR59RzIBZv4hbMsqY8xhMcXRtkrYoZcTW4FP8f
         bJQA1nODMVQm+U0SCO+Wo0liGeSJQDyUxacs+ZPXB+X2HUQARGAU+Dt3ItFoamuDMNq9
         rRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785484156; x=1786088956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bS/CRKVVoQdAkaStuerHlYKMhi3opFXvVsPmcBA81Yk=;
        b=Ij6Xu5SbhQRkdcpLar9pGu3GqMOd/DtP5GGg5rmU+sy/033p7TkOjUuMqSID0iDUnR
         pWAZ0Q8fOCTHqIjh9pDOoZmnsbkJVCHG/FRhXWuB6Mayj3X63JFg2cSSwGIR3Vrz2Ewf
         rTI5o2IoQK9WzKfWTryDEboq5uYxIyGleUbM7/6Mb/zkRePtnSJAcHSKEdm5s1u7uXV5
         2QphS7+EJUllICMqzIF/PDI23cyJ+zIaKCQBc2CpYNyC6IQgVoJE9YOSnNN2My8taRyh
         gwMcsdKN7oDvCI9bevTnQ5v6HmwUX2cVEqB1qtm9rgScJuKrQMcSSu5YUxvJ+nqajbTS
         Hlyw==
X-Forwarded-Encrypted: i=1; AHgh+RoT2lBlEqvI7wH7qJ6UOBfXoPn3XV1iQFHaxGAM0ixckacCuD+YZq4t7NSTKKOl6JUojsAvIKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9MEsbusqPEKOOHIgTArkUS898aKDgPCrPfb8cbT7MjAJ+/Cx
	pwABj2oK9uh3v4ycOgvpM87BAkDbC4rnSf6+KA/5aS3zEOu4UtB7loWA
X-Gm-Gg: AR+sD11si24QJng42xMMCo1gy1cjEOB7LIAkAuyAKkyWARLOtBLzBI5wA2PfVZhb7B2
	Nfe+rEs2C0SRBvhsCy6pMthU7E9qXrZrEWugEKfYEhiaA4l0386LEut4URdtg97xukbdaby5KaC
	9LhxZCihww3eRqnvZYSXb039CIDO6aOGlPaCbFJqvBjFD/lzI2h1CKB2vaLkjtH3efnd5FIRin+
	SLCXD+FCpbjpolDt3TgrgiR9m22SZ26CZZR8dk54Z0QpxHjrN6gzEMbYNGTVSDRZAEXD4L0RQCZ
	Q5SSZqbtc+qXCF7oXny3GtChVxw4ZyqErUaqOGt0hPRhD4JJeERtErBYhVdKzp09t3hlX/T5C4s
	ZsU1vLofBBlSZ4fPxaoRF5Z0KCtkLyO00gTTXOmD5oY+tw33ezMp0ycOgU6rPROYn6FVhDPfIoi
	vJFP7YIJZzLxGlrOtOr4XC59tqFPjEVS8IqbWGo0mEih9DRVkI8X03lAe1fPLQmXzL5jn5x++WR
	tgwTquIqC6rV0WVLJERQW0a1l5ji22pFU8b0Wqg
X-Received: by 2002:a05:6000:1ac5:b0:47e:aa3e:e75e with SMTP id ffacd0b85a97d-47fd2abbb6amr2533204f8f.10.1785484155487;
        Fri, 31 Jul 2026 00:49:15 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfdc6sm2009280f8f.8.2026.07.31.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:49:15 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
To: qingfang.deng@linux.dev
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dev.taqnialabs@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2] net: stmmac: enable MAC rx/tx after DMA start
Date: Fri, 31 Jul 2026 07:49:01 +0000
Message-ID: <20260731074901.1163-1-dev.taqnialabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <507ad6a6-52a2-4c68-9ba2-5cc4f92e192d@linux.dev>
References: <507ad6a6-52a2-4c68-9ba2-5cc4f92e192d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 31 Jul 2026 10:11:40 +0800 Qingfang Deng wrote:
> This is _not_ correct. Instead it's a bit more complicated, according to
> their programming guidelines:
>
> So the correct order is: stop TX DMA -> stop MAC RX/TX -> stop RX DMA.

You're right, the XGMAC TRM with me documents the same
sequence.

IMO this looks like a fix on its own as the current teardown logic
doesn't take care of any of this. The proper shutdown sequence is
a larger change that needs per-channel status polling and timeout
handling.

I'll remove the teardown change from v3 if that makes sense and keep
only the startup reorder addressing the RX hang.
