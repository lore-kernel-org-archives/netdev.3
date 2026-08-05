Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6333FF1B9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923416; cv=pass; b=Ivoqsd6+4O7NeW6+sNymFFXVWLCASYQzxY7jfcVrUg1XAWl9eOE1ic02VmlVC/7GBlg/VLkbRGkzoeq7iV7THTVxFMjhYFZCjcM8AxzO7PMTSinQ67FbWmGTcIEb9BF1LPO+C9udUL3fTFAf+2jCmFoK9rh+Mmd6Tb1XocN5/Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923416; c=relaxed/simple;
	bh=jHUPJCgYA1KN5A6tvLYjd3m9HsBysMmEkVy6GuEua7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxemW5BjbWcKq3XTc28eQ9D7guoMMEnjFFSYcRJ02F5sFv6o5IpKkOlw2rtYf2Wn7tSMssc+ngJR4O8lN6hdao0k92lrirKxvT86m0inhRAaAikctq1V4/sNVST8b6ziptEcQwYR/15ZF2pxY1A8qoiT796eJp3FGoZ3fsa3teQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7CBDH5I; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7CBDH5I"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383cb94f742so802622a91.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 02:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785923414; cv=none;
        d=google.com; s=arc-20260327;
        b=qixxXwaSEUHD3jFml2MFEapX91/avxxpWcpEtCh+aBv6GUM8OEX+KFFNol7rbUTm9x
         uvB7mhAadHJHn7CUGTVC+6oDmtP/R7ovBGn/2I2ih6rcRrHw/e4EbBS6jS5XqDfXmqjJ
         Cg3mbmt4D0PLaS0Wwwh61mfk0CJVgtGaPGhc3+6MF8iyzIQJVwym7gik3PXDzxkx1O2c
         Jlw4/f5NgBlC1NAdn5DeIHLWaZwkUflLO4L2uPwxqBadOKWBTQwvBpOpQRsh6A9hHLfK
         buiosHT+Z3ltWr/4639vtjtObsnmPB9UxJ4CmP+SVPmTyhD4c7c9QPzYPkwW0ToETjyV
         F8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jHUPJCgYA1KN5A6tvLYjd3m9HsBysMmEkVy6GuEua7w=;
        fh=ShQfhseWFbzzyHxEtXvsjJ1YTg4p2PJruEDuXpA2Y0I=;
        b=NcZtQlOc8lXlXsDRoiueU6lYFG700ktI5HYBo6cAPbA7mO/ddBtIdAjTg5tpBDJoiV
         OirI/coAXWOP5Zo9VnBC98PQXWSS3WnvNQdJFfTQAdTbs/1XSVVe2Q8tOdYbpeSpfSGg
         wRNQOgINQmyij0Mm18jDjqmFZ6r98H2cOSGzt3NswZAy8VAtMg0ShEkeig/LO00HJBSv
         KvfoTYkz6Flha3sEbP58MjDQSStm5BApAEulqt4MD14KnFjHICSuBzlta3myiU8vZctX
         9nExcfe6tfUBV0JExEbHv7CGILv7tdwAe3K61zIFnnhXdshWv0A3eC6VWaAAfn8vI61+
         SESA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785923414; x=1786528214; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jHUPJCgYA1KN5A6tvLYjd3m9HsBysMmEkVy6GuEua7w=;
        b=Y7CBDH5I6Cs26obPGj05mdofUx86rLNxZ0J/7BxGG+ZZ8WDEuGU+iw2QcsbJmxolxS
         dpQ6LT2ED67ynNT0FJ6U3vI9xusw48zducdoScX/v9+zvngSkzJR72gYdEGBZ7hkQjVw
         nTbUE2o5Fky9DK7AmhXfHwTUuXmwF6YzKDCqNpFMXlEw+weq//GAUobUzx6+zLdpvMzx
         IJDjhDFk87Nf5bFoByht8t+PFeIE+bJdCu4DfTRoIJtIQTU3N1NTSk0TnYFG/e9kW2WI
         73yD79iNUYx1BSWF8lHg/oJjdqeDIuwa7U/F5G4t2lL1fSgaagLWznbs0YbvykIBh/HO
         1wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785923414; x=1786528214;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jHUPJCgYA1KN5A6tvLYjd3m9HsBysMmEkVy6GuEua7w=;
        b=kP2JLWyJls/SEZ5SUAehbE2iSccsIR3yI2Kk3ZKxudC9Ec4usrvqWwHO1xxthtnunC
         C8cmxsNPgW4yEmBg7jdUPNmzAgjS/uJivcXfDruSjK0ANx7jYg0HoOzUlHC/Gk9TBCyP
         kcmO+O762OQl4VZxNl6puuM58xYXzaasRhT94heWXKIOLFmqoYXMrAWugwIMen5gov+V
         eQlnDaek9jKSzBA01DOo0xKZUC7AVgJnGVwJz1xj5R1HxyQ0KPeNmimWck2zLdxexkgq
         Ll2cF3gKLoZ6NK/35CMKS+38vGvvuOd578PSQge4DXv54jw8XUAQcJF3P5Tj5ssYF/9O
         NJmw==
X-Forwarded-Encrypted: i=1; AHgh+Rryy8mb0LqKoOu+stKDrD5OIsu6R/d2YVafWG8vAdxTionecC0He6R7QtI0CKqvs4zMPFxZEGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybuXi5NbOxcqA+bWW5t4BieGCgCSVO3qmRm1BAPkeZ4xp6Djjp
	uwScwVjT8NeRZ7e0Qbx/KtM9nnHipkoCKj9kbtC23B4wy1jPFkEWLM2gUqYAwo+DHDLCTGL3IKX
	AISm7iwFmzeSLXIVDHOkdOOb5sPvvzhOtpy5iBeaumw==
X-Gm-Gg: AR+sD13efcmnEz+bJy9WHnJSioB9BV1QhWdQ7ueHmh6J6JEfPXbGHalawkv03aPWyRM
	nt9NvP8xYT8Km9w1AMS6Cx/GA5bLKM18OCGwvlvjvDaQh0Kqjct3h32OVj7o1wYOf2fedNFMERL
	m2RMD4kIuzajORkBU4qGNYGsaEHFnzxXDktixYw7QoRlCDlM2otxby4gZyqDZWqgxgGSMXQtUW9
	K9dC9VwefmU9TsVzlCGIQ20KEMCgY6P2CIJmYbg8rVOM/smkkpUNmMNSBWs31NwXOG6TwdrSPnr
	u499U3F49/MlMFkuBhP6px6K70H6pa/l0Ep3fdk2BktH6gycOT3E3C7O
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr5494382a91.11.1785923413872; Wed, 05 Aug 2026
 02:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
In-Reply-To: <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Wed, 5 Aug 2026 12:50:02 +0300
X-Gm-Features: AUfX_mxQJkvH6gd7UiyLtdgKCnC3T2t0k7d1o6KFDYDhAGu7VIA0zM6ypCj23Dc
Message-ID: <CAAsRjR=bQaZD+_VQONWeAp1z=1SGWXj1pnFRPRks4sFggfKYaQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 8/5/26 09:44, Jonas Gorski wrote:
> Unfortunately what this does is break modifying ARL entries with VID
> != 0, which is why I haven't added this.

Thank you for the review, your concerns are justified. I will drop this
patch and let you know if I find a way to address them.

Best regards,
Semih
