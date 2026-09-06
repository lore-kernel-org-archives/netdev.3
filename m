Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94336197A
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714558; cv=none; b=ZBu3HtS4NlBs5+ccTu21d2lkP5CFZwTD/5uVq1Axc7v6bNuKK47vjDA9ULq6qb1/KSByfpr6WKh0BfAm9nx5obwlRPlfoCf7CFgZGQjLFaq/5c+oUNHH/E10U2HBpa9nILY+xovBxE3LDsiv3oUtSP3u50McMggB5JLqGQZUJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714558; c=relaxed/simple;
	bh=YuAissJBxd/oEcul73Oqcl2w4eCknoHW3mzGMcbV8V4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DCgZYVvFR+HZFqQJIn90CWxWpBX0oPwSUa4JD36tgD+1KBv+x4UA6SvoqffELqEc3JE3RMldiHqtXo8mVIQKNOE28p58bg9ZtFvvigtDEUsft0SDzjWnQihVD8sgutUPcQ8zeWrwnMX2WxmeeB9oxcWAf7WXTIhLjMAqsCmWLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcuSwJGJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcuSwJGJ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-867a943b149so42725847b3.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714556; x=1789319356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yx2dnKqh0YARmk7SiDnWQoiCJSWS0Gox86DZ0zODi7Q=;
        b=IcuSwJGJ2ZYbj3csiAyUkOaEpS4X+Pfzz6izHgYKhMY6oTKr4aU9E1f0kh6qGDvTc2
         Pv/KDx8m8mLRAEC0vuR48m8BPN8U8xJMeFNYKQugnU5b/afEMtycVRPQyyd4d1lfduQ+
         LHB1HDL3TfvfvZ1gcmYCpSj90P9/PWl3piUIuB9E38ZFZ+1rxvi6/nDKIMrU3ESvMGV6
         ed3P6mJC+RKadejwRQ1VOxLhjYi+2ZiDbngbB3CFdn6yHiLWXGh9G7fGNJmLFMrzm9jj
         aXT8fnCa5wwZCpKzcRq7PKfxbrwq2CO3MJHmRKIxA3L7UjZVvbJiPK5fEJy3qMOII+U7
         5jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714556; x=1789319356;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx2dnKqh0YARmk7SiDnWQoiCJSWS0Gox86DZ0zODi7Q=;
        b=FJyEfQD/HFrysUgDpLoL6RlwMD3UU4WtUi1Q3ASg9t/t+MmqW040sJ4CQ42+embgqt
         Xj6hly+65hte4Bjk399vCC2eOzWQre33+AbrNdOWHRePLfhYoppbPIQ25I3GcejIMcDP
         WVNzAhA2bNpPmt9IldTDXYfDEZru3KvkUeDhYeU0EifZxT86uk5YwuaZyng/wnrhE+bm
         jaUxzlMQ/UnTPNYgmE+mXc6TqkLSAdeB+ZKR+2nsAV3rmka+iXPIL+02h7K89DARs80G
         9WJPmjt4Cawr7PBsH0b8rZLki7yBWh5M20X/84hP1QbTqUp5e+lMn1NJwwsdiUIAyII8
         qUBQ==
X-Gm-Message-State: AFuF++mjGilu0vX1T9z3omB0h6VqHKx6KAet6os8j/6u8tKExQRUm5WH
	0bZxw9daWTFgriN3WN70QPr4kt7XcPBufu/WEzY2k1bLrPOshLewPFMJ
X-Gm-Gg: AYBFou3Z82fAJOGGYi1PebJoEVFDRdlY0A9bbEg6aD/hVY3jL12liQSgP4+bcJOk2pp
	7b2IfBd3oR5hENDk5oJBiadWQi2qbNyuJSzz6Ql9OOhWjFwsLkRKmqaziQkJUnYA4PdfiG/Zd9/
	0RSt1+rp2BzUrQhZs5iGXz89voFFYrbUDvPFU/7Ho83edjyjolHJYSIk0POUhu3Bg9fcUhkbze7
	UObWw1a9fKIjAHzJ3hbXHvq5g8XU5Hupz4mvUVeTvl1/xyXeauyzzOWehdcmBbKjJ7V0Q99vtzm
	vNCEp/ZvYaorr+TSPHHCvlTFaKI+wJ5xfqCZ61oJTHVWPxoTbq8P1UPDbExb179BB3kH4nCH9T5
	rkO1qf6dTHCxDaeny6tYs5ewTVkDeX/O7reqkqYmoJuC9TB0Fqeie5pKixSKRpA088x0iqq+RFJ
	enEOvBbntbR9qFSAxvvlZedEMCKfTLiydJQaR3VRsvg+X7mxPEprQZ9DnOkRh5TN0Hb5EWhkzyw
	oZgE4XhpYxZHdJNSp0PN2fSGetScBJcrT5DmT2F8g==
X-Received: by 2002:a05:690c:d8e:b0:870:107b:6353 with SMTP id 00721157ae682-87126c9bc61mr65866247b3.23.1788714556284;
        Sun, 06 Sep 2026 10:09:16 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316361sm57718437b3.14.2026.09.06.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:09:15 -0700 (PDT)
Date: Sun, 06 Sep 2026 13:09:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.a00ab9d6c61@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-2-d47e9c4c375d@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
 <20260903-psp-prep-v1-2-d47e9c4c375d@gmail.com>
Subject: Re: [PATCH net-next 2/4] psp: move code from psp_sock_assoc_set_tx()
 into helper functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> No functional changes.
> 
> Lift code that needs to be called from both initial tx establishment
> and tx rekeying into functions that can be reused in both paths.
> 
> The plaintext in recv queue checks and mss adjustment only run on
> initial tx keying. The dummy psp_assoc machinery will be used in both
> paths.
> 
> psp_dev_tx_key_add() absorbs the dummy assoc machinery, as its main
> purpose is to populate the device specific psp_assoc:drv_data.
> 
> psp_assoc_set_tx() exists so that a future change can allow
> psp_dev_tx_key_add() to be skipped entirely for devices that don't use
> an SADB, while copying of the tx spi and key into the assoc needs to
> happen regardless of SADB vs. no SADB.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
