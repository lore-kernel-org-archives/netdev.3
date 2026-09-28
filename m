Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBE4A9D66
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594548; cv=none; b=SPIh013F58lPwVVSk4iAEOsKwNU9zR+FYIBoXSirylditipaW5/7deMSxAaRMytLufHo+P5fTwYFmO3ayffxNS5uCvAXJyw1JSlucqUpn+nJ69e3EYeHXghqt9pKwTCv+eowAYnhOcdpEpZlO9FVs5aWY+WmF4V1zGRY9vPuLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594548; c=relaxed/simple;
	bh=aXBz7AR44Q+XFT2m+cXKi6eqcxUxKqUyNvVRzRqKoVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jahUa4uQmjvLgV9mijLYsfJRDLfTYLaPqYO7tlwNjJGevPU5cZvIOKv1/64UeF7XzNE5FtpGtthjXVgyTw2qW9u620/3GwT4lj3Bs1bqIFTEed1Qru/xCs+sNIkQn78XDvATLFSotGlHjxPvue6Htd6/KufVtDftTnompPI+9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoXvOtOB; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoXvOtOB"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso1179655b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790594542; x=1791199342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vYn6BRMPnQfcxHQ5W7qQJ0yu5Tu5tvbhzOTrPB5XLqA=;
        b=IoXvOtOB3OecBSDU/4mr084c+mTdaSqIniCChOJ3dYW8PL8Fp5DLuQqtJnwdlTqLxU
         l7bX+2ZOSjpKAusw73eKlpCk8Q2VEBN2h2KHx3EwCWDFXNShWDLaPQG1sLFREvp1QfmN
         QRbZqZO4aBXBLW/AkoOQVyTYYPbdpK7yjvBOekzbki+8sgRkzDK/L7/r5Le3MuLeoYX5
         yGkNNSKBb8UWmNvGXzzU64Ej+ONHZ6NQ6NfjEeLIG6B8gxttJYHQdX1lccEnPfl0MRN+
         BJUMBp0et7FGMe19pSSbzvg95pMKQXAsfkM2MGSHleOv13L3ZMSPWevwOs3SftiwIUEn
         aggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594542; x=1791199342;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vYn6BRMPnQfcxHQ5W7qQJ0yu5Tu5tvbhzOTrPB5XLqA=;
        b=dziH2JwIfHzPJblxpkzcbpxfSZ94JvUtmh6Cmegk46ugG66WMap3nslhoHSkh++kmv
         Rtgyw7vuj9kJoYqjhBL694jreA7YiXZfPej2RL82RVZe8HZONll7n9vh/d2hFmcYSHUt
         esytqnb82Uw4hh1gA2iW/LfZSi+DMpHA6wM82LkJpYfqdedc0R5s0JztBE2w05fVP52v
         lAFugUOc8IGydWlborehwluj/vjxZ15+PFEjOH0yUF35xRroUPOdKlyNBieOgL6T4WCN
         Kj8cbJyuHg6ZL2x0FN+uHvEYckQBV2fIZNAJbAF8m9Ac1VDndePtQwtD8ipLCbpsy4cS
         1OmA==
X-Forwarded-Encrypted: i=1; AKwUvBzUaFiXsshC3ybsR5QYeGUFVQe/f0rGIK9pxB3OMY4kkEIHHaRqfyqBOOl3Jva3UvCY4VncSlw=@vger.kernel.org
X-Gm-Message-State: AFuF++lvSHzhZJ0ZAjoxEiVm9iAQk7jHG8rnThn0EPY9B/414ojlP071
	Li5w66f/ogdVSuz29tNcAwE0rbHOXk9ZzGzg7zjQ3Tu9dvbKEePAAljH
X-Gm-Gg: AYBFou0LuBOrLEa+hWCPjscHq8rBPrTew1hB5je3ermlEUBVI+7mM66OJH3hQbAfksS
	5lhw4PrCuX/5KR0TqWk0bbDAjZ/ZCXeEVPi24WgEh90cTowqFsCdGdaRY88x8N835nrHvbSzWoL
	BzTgUF/7+LqNcEKsjkbfOoinRNJApPDsCXNLhnaWC87TMj3oqUavzGMcWF4W7uKWbJ5D3vp1zpY
	FHizjMe6WWd4tYUc0TdLE+YuNjIVhRW9FpGCa7HVMAxsO7T2SLojw6QOoNN54Jl9qu1Y4JATLn8
	1gjMPdYgONS47GMP1VDXVqUZ9wsjCQAuE/O8g0VTyW7WYNJgTct9cNj9mHAzjAiZLDnEdIgeQ40
	iGO89RlhU5Psc9v3z7IgXlPfZZOn60p6geJ81sn28Tj1xr/BPnBPNrQCCMNskXfBrXyTB3vipFL
	lirCm8/GeWTYAl8x0tGbog3Z7XqprR7ifFyoJABrWC4hG1EP5SFncd9fGZqU579FliWogL/S96L
	65s/25GD60=
X-Received: by 2002:a05:6300:6cc3:20b0:3de:5ed3:36f1 with SMTP id adf61e73a8af0-3de5ed34aa0mr1369006637.53.1790594541603;
        Mon, 28 Sep 2026 04:22:21 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87ff54fa206sm3877110b3a.0.2026.09.28.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:22:21 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: pktgen: reject out-of-range node indices
Date: Mon, 28 Sep 2026 20:21:04 +0900
Message-ID: <179059386581.3965069.15320036220559790742.pktgen-node-review@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928093243.GL13925@horms.kernel.org>
References: <20260924053752.1442623-1-4ncienth@gmail.com> <20260928093243.GL13925@horms.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Simon,

Thanks for reviewing.

1. I checked all 32 num_arg() call sites. Its unchecked accumulation
   also wraps on 32-bit for ten-digit values, including count and delay,
   and several destinations narrow to int or u16. I did not find another
   direct unbounded bitmap lookup among these callers. This is not a
   claim that the other conversions are safe; I have not demonstrated
   another OOB there.

2. kstrtoint() can handle all valid node IDs, with an explicit
   0 <= node < MAX_NUMNODES check before node_possible().
   A direct kstrtoint_from_user() replacement is stricter than num_arg():
   for example, it rejects trailing spaces, whereas num_arg() accepts a
   decimal prefix. kstrtouint() would also need the bitmap range check.

   I propose keeping the existing ten-digit decimal lexer and using
   kstrtoint(..., 10, ...) for conversion, retaining the existing ERROR
   result and write count. This removes the duplicate accumulator and
   prevents 32-bit wrap. A host comparison against the pinned parsers
   passed; this alternative has not yet been built or run as a kernel
   patch.

3. Reducing maxlen alone does not enforce the bitmap bound. It also
   truncates rather than rejects excess digits, so reducing it to nine
   changes valid zero-padded node arguments.

Regards,
Daehyeon
