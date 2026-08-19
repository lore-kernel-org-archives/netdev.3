Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F472765DF
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106991; cv=none; b=ZFVSv/uKbT3QM+5NqpRxQEusOugVyD+Qv7uM959tdqg4iTp4k5r93iA4nLc75OwtLadBs9/YuoZwI5mhtlUiz+nUuEA8EeRYBx9bPEOl+0FmkmvvuiGlFoNIKNMcfJwo4Jl8e9MtFLnG/yzBqYpVFUTJM9TPdVFvyEJfxCwCeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106991; c=relaxed/simple;
	bh=+y/fGrEl3GmWbk5L5xzbYjpFffUEOhKnU8k48BKuQ30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+deOyzuCQVed7TtCRcq7rqgDG+50O7U4kIowvquoglQin3wrO88s2PouFqzfYQZKC00Ry3VOhP4wMgNIi8B+r2dvoqkSGwiU3fTKop9KHfQnE2dNAd5b54qzJXejOijpR+rxc7EDTetzCLHVbi5Xj3z41BxW4t3o50Va0krgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+uJtMJh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+uJtMJh"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836ccf53ef9so6673467b3.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 19:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787106989; x=1787711789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y/fGrEl3GmWbk5L5xzbYjpFffUEOhKnU8k48BKuQ30=;
        b=n+uJtMJhOjxUwAJTF25n7/o9nB28KO3d7qYJzsLyK1ldXt8fB0eN4YrJRM1rzAbznY
         jbNazIiKIn6aF4oyCxMGLqceQQiw3SdM/QUDE1vZOvCDtt7aAQS31lGwWWp52Vanqe09
         Zf9mzhfkBcjZ9p/olUhM2sBkaxhwmZqBAYyvqJQS9bik30XOM8qPPB+BYvA/QoZgyYgU
         0NhfuMQ8rs+4egujIsO2rkurDql2ApsuvgX5U8I5D7Z9k+3mO5W6/JpRCq0kNInKCVQ0
         vlts/Kms7Qz9GmqADjsgW0KRDy+5gQTbx9UvdQEibxC+ynTCM9RoIGTOtz+wKRYYGPjv
         hB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106989; x=1787711789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+y/fGrEl3GmWbk5L5xzbYjpFffUEOhKnU8k48BKuQ30=;
        b=Owa1DrXdynQwyB+iFBjIPSiUDfgxOqHdSdcvgYlmAO02tivYuTRMLaAtGf0AeCBZf2
         59pG/kT5YzCXJPJr5cxtDbmp8yKf6IK8dUQKV+2d2X0As2XkUNbFImJfYh/kRB1zoQhk
         LWgOUQDyxxWlEkGsLBazSQFO4L7h24chwFbSDofGXoV1jeSGnqYOV6T/gseC08NM8+EF
         mQR8ZKyZprTf+8wNp9/iF4654E7fTxcpTABNw3b7rMex+Q7df9tUC6/xICS4y3fsYFe5
         RXzgGOZxy0KnKJrKQCz6lJy9tvCfXsXiBsiuj++cJhiMRKvKC9ZPL2kla7I1NZWSXpsu
         ww1w==
X-Forwarded-Encrypted: i=1; AHgh+RrZRq8zzrOSYR43Tk0R5XYudA+256GvYSFCnKajcWMly/fMvECmXsrfPbGa7K1+7q3CUX2Xvnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNOLLbQx01UxTszq+TK77K4b8umaoKbFzxFy5PiE/b9VXYUbY
	b+XY+mSKL9IG8ABjUwJ3m4KT74QG/VF0MdqIFzpz3/H0vUbUF04+tfdY
X-Gm-Gg: AR+sD12n+J3xEnUdjrl3Sma2HjEQQeKlj/iMPayv78DKlbpVYkmu0pIohCLRlugRjz/
	N453K/bpPIXZsa0vmvLiW0oDvDgYw4u0h5eBJ1bjl/65E9RGD87Az6Hon+bustWYuavFn6lpZG8
	89ShqR7IVwV71uwbIpiEvSsjlXKAGGsPANfwb6SKUoQQbW2eofUXYskpuwJQEq4QBQ5Kk0zUXTs
	O8a7Xet1/gtJZoo5JGiAaDgXLqMvqsAv9/Jgk5AvjsmkcKY1zHLdjc9qfRtH5NfcdAQFAlMBIz7
	FVyGLASZpKlB2K0rqV5k4USgwDafusiVzO8uW1KlZUgfU/O1LRYGRPthTYZ6uhM5g8Yo/1dsEkW
	K2QzknDGSHqnk4+TL/1fK3F/klEhkmayXqzY+dd0Eone2T4tSJzGXP3/HqmT/0pZGeTiBT3Dqk2
	M8Xi08eZrGook/Jp/JveJjH8crlkAPGMALJHYFKUQJkealVAqV9Iz/D/4rW0wulMrWvXV1N7v9Q
	xoJNJNVT6ocK+2UxtyDADQM/f4TF/jqCQw88lYIBqkGFdjoG0+UQBvOAvy7FgmuVOYdXUa7AScp
	DpkaVZnzX0M=
X-Received: by 2002:a05:690c:c4e6:b0:81e:ae6d:caed with SMTP id 00721157ae682-844e8d26b98mr6979297b3.34.1787106988841;
        Tue, 18 Aug 2026 19:36:28 -0700 (PDT)
Received: from localhost.localdomain ([103.174.171.5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8451772d1e3sm2285177b3.30.2026.08.18.19.36.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 19:36:27 -0700 (PDT)
From: James <aslan.jnn@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Date: Wed, 19 Aug 2026 12:36:01 +1000
Message-Id: <20260819023602.10387-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260814100916.GL265046@horms.kernel.org>
References: <20260814100916.GL265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 14, 2026 at 11:09:16AM +0100, Simon Horman <horms@kernel.org> wrote:
> FWIW, I lean towards this being an enhancement for net-next without
> a Fixes tag. Rather than a fix.

Hi Simon, thank you for the review! Apologise for the late reply as I was
unwell last week.

My rationale for targeting `net` was that the driver currently accepts bad
FCS frames by default, which I believe should be an incorrect existing behavior.
The `NETIF_F_RXALL` I added is intended to preserve access to that behavior
only when a user explicitly requests it.

With that said, I understand that exposing the `rx-all` control may make
this better suited for `net-next`. Do you prefer that I respin this as a
`net-next` patch (when it opens later this month), or do you think the
default-behavior correction justifies keeping it in `net`?

Regards,
James
