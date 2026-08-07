Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F51B640
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786144698; cv=none; b=j9KmfuqcSBG0DRsDrpmYNP88KMw5c49oay7RFeLdy4Tv8NIShhARfeMkeZ2+ZNdFmsU4BJzt8m52D7TdTtaNA4uz/Fh36guk+oPns0ryz0FUntbzc2rbfgNmxqR9J9PEpWPq3kwCO6bOeT+Pn7gfpwCt7+03JOcYdoTq8oLav54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786144698; c=relaxed/simple;
	bh=zpV/i8GSCP4xuXj8dQrdWJpY2ZIH1vjtPVBpIoJ6U08=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GuyOgtkW1sv+paMC4RhqWFqvLwCYhUog81NGNNMpM9YhEkgttMiz50W2MKnWWKGdS/mSNm0QvMt9LdTwM6BKvpg37/krVUad/0hWm9EYAkDcHA8YWIalw0m4dxqAHkuhfTXQCQ4XULc4b4gl903cDGe/WjbJOybuCdSuQkiLEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2iDvo4Y; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2iDvo4Y"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80e24970f1dso577367b3.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786144695; x=1786749495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v/BYCb6+3dWK/veTq4j0zRMOD51HKIQXtQrL2bTHrVM=;
        b=X2iDvo4YH424p938VtQLeTNj8pQnsmjMEEnEWthdQhhTDb63MuIJEChmpd+bkfT9U8
         H0rkePFRkvnJANxFwWT6T35qsDfOzi6WX4ayLQ3BQJzZqVqd1M91h6ouRDU4suDA+NW5
         GKTs+SP/a6btSG8dqEEAvvVwDl5VMNIod54yYmSDb4pcZyjf9kdAfVrp5X2g/9wLglQH
         YpECB1vPCC5znjPuDLh3imE2a0s1rL7LAuyvUm3igytqiF4mV1TpoyEfA29L9e7QSZeT
         /+D51T+k9yJ7MD4/Sc/pJqxi+29f1eJzQYUMVw5Lx7awb4B+XRueds3V5LZB7Fv5BRyG
         rrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786144695; x=1786749495;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/BYCb6+3dWK/veTq4j0zRMOD51HKIQXtQrL2bTHrVM=;
        b=I6Ji4MPEWREeQQ2wJxPmkt9S4/WUSVtAIfOtecoC2xBmPmJXMbzZBORnAERUIiMLqm
         o/Psu+MDHDECL7Ly5DETRRznsQP3glIec/XjlWbMg1Mh0Famq4fq/U4CQfYeDeLTDek0
         D6bzYTjM8U1gN2CsX9DcGZIcX1HdQNiootDOVhBmPQuYu+i1jF4avHfxnnF1FMyFjU+S
         +QkEbm6KIGjyI2StTMlXkIKLO+8xTlNv2r9+K0OQ6R9m0BIqYF26GmIEfsjZTqOR0qsl
         Uqe1lApBKT5B9fO/xEI5S0O5fKjJeKFJXtKn10StEaaVmUU9ns381aBqk8IKZZPleNlj
         jhgg==
X-Gm-Message-State: AOJu0Yzf4OZEqfbZyVuB/1krhkBfiFeul1IhinJFURVAdEK1RD/reXOa
	Eb4CD2Nx9vA3TdWU2AG9LVoBIKKwcHQISyQegaM8Q1nabFKq2w1XWcl0
X-Gm-Gg: AR+sD12gGrYeuT5dsq/XjYKOYXWRe9079gd3V283bRXJmZU7sCuDEYGebYWi67ifglb
	T/GUtfqjGgKfUikQWTw/UNl/qfMHZD3a+dlXbpxQJLhRz7gS5n+O4hciLpWtD571+RcG5kVZtfg
	8Ej7VvGg+VIHBb+OOLb7PGpaVVwiBA82PNyXMy/5XddUvXaqZjOJe+11uy80FhPmKEJBNllhFIF
	hINSBJ3eMlJYI/Di4Nw92LVbfu3QM9RlyRCISI8Lzn6PQwkD/+Y2oHvDOTT3pAKM7LR/SicON5C
	FSenj/oDvTviMiTVkLjyxxKg6I9W5n7FsoFyPK6u+JPX6HMDzkFtES2IRiV5M4nZk4qzO2N6u8e
	ldpi5H502xmNTYqKmKnjZZUnTdjKrZf/oQQdl0FjaULVx1FXMgvtniWBheEdDsEjgo+9NniH7u2
	9xotv+3xewwMkk0in2GRIMVAYGXtZJuOyMLGE8Uvf+m2+lpPObrpbjyMUOB/Ei4u0JFPENl39eu
	uoY3TnMo9T4x42iSOR19wFu11OzfyvoxowC
X-Received: by 2002:a05:690e:1247:b0:668:bf66:4e69 with SMTP id 956f58d0204a3-66ac2ff5a98mr7453934d50.36.1786144695575;
        Fri, 07 Aug 2026 16:18:15 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acad06ad5sm2158819d50.5.2026.08.07.16.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 16:18:15 -0700 (PDT)
Date: Fri, 07 Aug 2026 19:18:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2765226ccd5ed@gmail.com>
In-Reply-To: <20260807154525.7a970468@kernel.org>
References: <20260806173702.3857148-1-willemdebruijn.kernel@gmail.com>
 <20260807154525.7a970468@kernel.org>
Subject: Re: [PATCH net] selftests: drv-net: so_txtime: only send test traffic
 to sch_etf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu,  6 Aug 2026 13:36:57 -0400 Willem de Bruijn wrote:
> > Subject: [PATCH net] selftests: drv-net: so_txtime: only send test traffic to sch_etf
> 
> This should probably go to net-next - where it does not apply.

Ack, will address and send to net-next.

> I'm not sure if we documented this but selftests should not be treated
> as fixes, unless they are packaged with a kernel fix. Or you _really_
> need them in the current kernel version, but then you have to explain
> why it matters specifically to you.

No need from me. Makes total sense, but I was not aware. I do not yet
see it explicitly in maintainer-netdev.rst. If you want I can send
something like this:

@@ -66,7 +66,8 @@ driven by David Miller, the main network maintainer.  There is the
 ``net`` tree, and the ``net-next`` tree.  As you can probably guess from
 the names, the ``net`` tree is for fixes to existing code already in the
 mainline tree from Linus, and ``net-next`` is where the new code goes
-for the future release.  You can find the trees here:
+for the future release.  For selftests, all patches, including fixes,
+target net-next. You can find the trees here:
 
