Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34C26D4E5
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230269; cv=none; b=c3cSeAykTQsixm/q9gGqIE53/cOnf6iqcmSTkPH2qSeWSFcqyUoRaWfmwGsLWGsHeGkRf1FGzijPSQmOa/5SI5rdUaO9OyzKnAsyEeT2rjOpnnQiZgIuhv8R8qS3ow5taU4viAVrILU2nEqDrhHQWGhrIXafnlYuuKYSMYbTjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230269; c=relaxed/simple;
	bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7pAcEnHjbhTKBPY7h6mwcuLU0lhJzf21CanhHTaoK0UNlD/Cup4An/c8R81YHTTBcJEUE3W2oHBp/eMFPdTvQ62PjMvUH53QJY9i46H+voWvR/HxxObeoukZzx2Pp1h0xSNy1VbewBoAuGlQeDrZLNUu1npfiN4bb0YTyFqWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=nUFVskNi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="nUFVskNi"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so56528615e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784230266; x=1784835066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
        b=nUFVskNi1dPSaAVgZsos6K5Gys/P/GX0tr99T3NHFzhcBRNNV7I8B3c79YxdZ34Uza
         FQKrDpPH+ZXbRQvanM18qTOBBeWcIcJxit/MVPtah5aUP7KORox8/F/WfaST1FYRxz1P
         zRT944s31yzRsaM7LBQ5lHaPOoIu19YhkhP5mcgwRVx8CjwnD8uDMyowYyUtCLNS6gqG
         01k5vVKx31C2ryY2C8qkpnhAFlbIQVgwVAItxAXDpURnu5FLYI+nn4vYfCoob6fI3mLP
         9knjAgJmXNJCTHe1Ol3b5CGTozun+g4TXSasAwhL4JexLMIiBGEhu3YE5THsd5zIMFWw
         +Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230266; x=1784835066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
        b=VKhBCFNmqGOnjDY0o/5j0zHIxEEU80lj2N+QEKTmlCuFiCNX1OZp8/+k5rm8Qc8nQJ
         Ez0vjjPQD1ebIJ6jZH+74kFhufpDQhwPUF3gbuEUZG7L0lKiZ0orNIB3oqNsbPu2Docn
         tEbBDMEU2dVKSfmD/id+jSJ08bs7GHEyOTV6FgZjI7tx7xOzFkit9xrupGK2aAaJY2fn
         rTLGQEpU3okfr2ClVXtq+l395CInaQzuuDT+UXxW8oYLAuGypy3a5HPmLMWm1cbUDw74
         2Cd0PzlMk1HW4jlAsD3F1cunTDspIr1Mx6pE6EKK9+MiFkcVGVXAXOLD6BVlbw2Iuiy7
         M05w==
X-Forwarded-Encrypted: i=1; AHgh+Ro1FfRYN4cyJnxBMTnxC2VRVDibuhUhCAGhm0BPBAScjePhcqIoNB7xNF2Hc0Hm+cETA6KNo8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjL9QUeiqaD692zx2FVAXeQfh55u2PuEYYb9QARhBfmxngxPj
	l9NuJJtvm9ATM7uullo3/yf2KvYlfZ0IxPzHSqZVq8tnoeNy1vGlDFJtZ4NiyOSNmNRs
X-Gm-Gg: AfdE7cnhALCY0+zRQwUt9P6f1Cl4bYUBRitKyXou2PJj3uGuO1QOKJPjT6lhZSiGLOm
	Xus260A666hLMGBftqDtV+xV6x6vDLBAqgrK+rxWRrZ8ieHdyyd/JvEaABkqQqBtz5IjVTfY2jd
	wR+4LYRHBR54StAWikfNU9R85ds7IOr6dK1THtjZ31JZxMKpPuVw4AeLqktFBLYBsf6lvMnBsA/
	1qbpFf332CYtwYduA9PWeCU8+fz/25rP7AFbrr7vogfB2g6i6pR1B0D6QTnuGOz2fkyisg+u6kw
	TU8M2WlOJc2FhQ0n2nKbX7YvICWj4lN3+Rum6lBjmQulMgSviCilSvqvHfs4M90n387Krc+II6E
	+MHIg5mZ1pap0MJ6580ZQv0L7E/YWqWqt2scVndzvDbn/BZe5bY/qT3G44eLdo9InEBFJ+IqTbw
	94I0lCnjLcGsVDmG3lLVL12q7NIYwspuFmHzAE3OuYHuAIUVH5PFCwuaLd7GCjiH5QdQ7trUYhX
	d+jJ+LFBP4tDjuYGgfnxCD4
X-Received: by 2002:a05:600c:83c6:b0:495:3a61:b67e with SMTP id 5b1f17b1804b1-4953a61b766mr125503845e9.23.1784230266106;
        Thu, 16 Jul 2026 12:31:06 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7f7f7sm77535685e9.2.2026.07.16.12.31.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 12:31:05 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu, 16 Jul 2026 21:31:03 +0200
Message-ID: <20260716193103.30558-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709131246.44517-1-doruk@0sec.ai>
References: <20260709131246.44517-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will do both in v2, thanks.

-Doruk
