Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468B558201
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881589; cv=none; b=NoJGdtgNF/V3TXxp3Gle4CLWn1iVhWuXLxV8ofv3sxZsMXX8/P9T37xgixccApLbfTBL/Tk/a/6+NuY0YCA4wjMPLXfWoJ/8YOoUpelrYBnuFDjeSGPisDp2ggSK6Vwh9IymNfRXDkxtqC4r9QwprtDSUYeP1pAuLa8+6+PMmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881589; c=relaxed/simple;
	bh=Ww/HCHAxv9dCKdcDO+JrI53B48M1VI86UHdc0RALheQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/5G9O+zfBR+5ky+WH5jJRnm22tSliw0ukeXX7pSB28BUHPFtm8CIKtakMvAUde1p9VisxnOCIsBd38cv1mwKBzHUdp3taTS9vK7PjXsRMwL/T1AsR8zJ/ugPOfAvBBkSalvVVpicTD/AdoixhL6fgrBYc/TMcyVWkuTtIcIRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=V3bcLFa9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="V3bcLFa9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so27785945e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788881579; x=1789486379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ww/HCHAxv9dCKdcDO+JrI53B48M1VI86UHdc0RALheQ=;
        b=V3bcLFa92W/ou9CwvmY3wqazpQj+O571/xzmk40m2X/mqKPYXOTy0a4wwc5DjB7YtY
         BpQrdu5Sc4+xjPJ43VXdMHHeun+yn/21W2pxwae0fKZFfW0hbpyWGT+Ifwnt03uL8kcu
         vtEWP8z3HU4ioBIKFfcxInKKuBELdk56kjYQUcCFoHMLtuSojwzRfHggkm01t1QoT3Zl
         ow6Wzh58D9eiXX8QGXqyjyqkKi4yVdDLxuhTflNaae/6p3KlnQt2SWNjaxnKt+KIaVr9
         j1QVx7+IpYAvADVUrnqfizCIbe/94JHHqNYt9KhoPK4UEM8t1J2burPlX1rOIWCTvbkv
         Jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881579; x=1789486379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ww/HCHAxv9dCKdcDO+JrI53B48M1VI86UHdc0RALheQ=;
        b=N4awJeDMdfuAcFL83dHtxp3sYNPGrtLz2PHmRTj4t2ur57ORMMl1ojnvOskxEVE3KL
         mbP+dOkd98MRQWfpUHXFSEaL/4fl44dycefuiJjqfhWZNFzaospbTekBfrTe07jyciPg
         ko1Zje4ieU39tqfWEmti+FrQW0oWIHIh6kqw0JUlHZGyyhV0tiSjaPAKvlr4Impm7B4W
         Fpd4lg9rmEaoQBC6/maF5YJaPbgR4rJDOFxyHSLvcEjCcTu3x4QWug0BjOtbuwipB0fl
         oISXASIlm8y2cbeGfP0KNHP36vrbGnSkf6UCPB4YJd7I9ysEW3jasJHv4+4+w+c+8ddv
         pp2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYziuLtH0e9CFXCsp9hy/Drj6VFeRkwrNx9NoMKFmXXFnpl5ix+w96iVBljhBZ3vzJwTfnUos=@vger.kernel.org
X-Gm-Message-State: AFuF++nuXWI2bVfVQi+81qjj/0GZ5u67eMGjD1YQlfjo3yYDSDQflihf
	3+ciOlsBKtPowG9e/8Ape+A8/ipmhsgU/7640DGFscmvqp0SA6Ft6mCQ8wLa2yYN3bc=
X-Gm-Gg: AYBFou0QAkrBZ0L5PnyleRRbbqu3en0GhVAOGDKIK6JJYD1U+iOkOs24yHjomTJUzsD
	sxuTunNIZRLlgt8B5zq+IwWkpSkBjDCgPso25s4JmWr4ch93ZIJrgdEHJBg1lXwIAclLfNCdnCw
	/N//aJBbp7BmdxOYxqRiff52MefV9YdIZxulSG/fwuSGoLFldcE9ADZwSI86GcyoROIdW1sz+S3
	8G9Q4WqFxqVDJTE9iBlgs6CXmwDyevcAzkiGIqg0R7bQVrPSy4Hu39cOeGyJg+EKe9PhLWgPaxd
	7DIaaCz+vap0hQwf/NGoDYgy/7UrhN9I20+O1mzyW3osJOLRp4AFQe9q08Ppj/vsryvDdX/13x9
	+pSHg9vwF8ERwRGU/lDhmZEigikVkPZnDf12IRBiM5M8/mZAJS0emkwfCPws4FWunU5xYgFVEQo
	w7yHtXMBghMpHyQf0Mf10a4buCUoL80xB2HZKQf9Q=
X-Received: by 2002:a05:600c:6211:b0:49c:fa21:1c88 with SMTP id 5b1f17b1804b1-49cfa211d8cmr238704215e9.29.1788881578843;
        Tue, 08 Sep 2026 08:32:58 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1e728677sm9639315e9.2.2026.09.08.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:32:58 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Paolo Abeni <pabeni@redhat.com>
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	vineeth.karumanchi@amd.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH net v2 1/2] net: macb: zero the link settings taprio reads back
Date: Tue,  8 Sep 2026 15:32:53 +0000
Message-ID: <20260908153253.4144665-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6cfd72f7-b6da-45ef-886a-7703027a55f9@redhat.com>
References: <20260903123652.23900-1-f@lex.la> <20260903123652.23900-2-f@lex.la> <6cfd72f7-b6da-45ef-886a-7703027a55f9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 08, 2026 at 11:44:55AM +0200, Paolo Abeni wrote:
> Not blocking the series for this, but note that you should actually
> specify the model you used.

I took the bare form from coding-assistants.rst, which asks for
"Assisted-by: LLM" since 816d9992d9ed ("coding-assistants: simplify
attribution"). The reasoning there makes sense to me: naming the model
advertises the vendor and says little about the patch. Does netdev have
its own rule on top of that?

The other half I am unsure about is the routing. The work goes through a
router, so an honest tag on one of these patches would name seven models
from three vendors. How is that meant to be written?
