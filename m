Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF55421226
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185778; cv=none; b=b0luODzeJZdDU28vPTWyEKpEofMUsczybICUKsxOU4zZtaJi+rUDtTKQHurDoZjW417AwA3fAI2vfcB8yXJeDxuWJ5++aB6gyS59V6rriWnku0eQuypkTQE2LYAyhpTANej+6tEjye8Lb44w/z0OBKSs0m+tD7LERGwXDQRthCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185778; c=relaxed/simple;
	bh=b0qrLZrXHcjxaMdguIqby07pC/TpQhegHwKy5tJHNHA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fiuZlpLpVPjfGNOUgaHa9EuYPg4VnVNnk0b1GWVnOlWivOnIClYziF6HAmrsX2wlZS6492Tnv6RVCKJzQG4xz4qNha6rvk9vawJuZruT6K6ym9yhu1LYgIjeop1CHgSejv6jsQm+uSII7G8qjWbWRnoQTWAKXWVGiZuNmsxwNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWaan63S; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWaan63S"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso558697a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185775; x=1790790575; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b0qrLZrXHcjxaMdguIqby07pC/TpQhegHwKy5tJHNHA=;
        b=RWaan63S3XBEf34onYxukqlDJ74B6rL/lbo4PsN/sDumTwMMfjCMq4PyeVSdY8PiN+
         OGeiCDbzWk8O/y0HJW2nF/AuxjwrCc2nrC1Ig03c2FMQi0BTq3RniXwuzREoFY1+mHlR
         CSlVKYeZwVo/zPSbfLBLgf8ubdiURu7aJTqVsVDHjdMLWqBCWmDtu2CrMBnQjjrmMM9f
         tc5TFAscc65Ndsgcq9k53aRY869HVBGU4g76GyOIxt86Dmx6Jk9l59oNNwUvb4gwZjN9
         Sy9QLGhWMyK6IkEgacSPsoRHjV0WEkg091LffqoLBRodv0z+y2K9g0AjvWh4g/i6jIeU
         tXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185775; x=1790790575;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0qrLZrXHcjxaMdguIqby07pC/TpQhegHwKy5tJHNHA=;
        b=Nr1obZaDa1iMAEXTGKnKhaG7nzYuiKFh+VDvvNdolJfOPb5Dcb3n1TRu2z1cilKe6Z
         RwzUMq0khmdhkwX6QpTPieMADahGbbxX69HzLIwh04DukaNq5XoCT7S7WMmF7N5a1kHV
         OSCxFk4mzWxZZJSk1l/7+V1XVPySrYozZI86Bv/03ccpmvc7C3ZP0OxyYBFVS2KuAsOS
         hBSSsUlyX3Zun/S2goHRlFfMPwGWaSfr6FHnCjAv2yf7+i3L0vT4gx6siNvsywrrajPf
         MuC4DOGcoYCcpKqLva7B6U1FW4ldQluWFuXf0G/n+y9UVls5aZ5Ae/to8oYN7eatDLju
         mIjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZ0GG2LgAud+l7VphaZeICi3XBW0VmT7C3kRLaGJqyfzfpyAHrekmZDIjE7EGnJAqF5eHqTRM=@vger.kernel.org
X-Gm-Message-State: AFuF++nKM54cTGiPgdEZ0bRqgGZ5AEWw7k3C0Vyoxd0zHAk34WA65A3l
	XSZadtq4CF18Sus+r9kY0l2wyR8vBuHcgDF0+LI06XmWt1c9kSil3dU7
X-Gm-Gg: AYBFou1wNZwdWlC1dtdUaNIlxFLNfREPRjRrf2kDAE6SCguWDE+YBdwtFE9ch1uQ20r
	W/063eO7oxNiX3o/iSMT0Zyb0saoBmgMz1H2U7W5jLGefL1SjmAnMaEr09ulLjp236TFg88jXWU
	6HBfKUVYsGBYGUpM+BrFwqRTymqOcknytyHz2nDqZiJLtphB0gnIkxWmAP2+JL10oVvGuNG6oAK
	tWuhE6Dt24/UlmAarlCHMS6oLQ0e95ophJW4czNgXdXTXGwInuaFK8Jj+7chr6ZpWJsI2oKKYCg
	loEONcRXeu7nveXSvIMPNptM7s95kWUlV0QsjwiogEZhLOvwKSOXygNKE0CteOyHXkT7S6jMx07
	U47GcdjoDIVA30QktUbW+xNJUgjicy9/imzXcYfSnouMpUQUzxuS7ddBD+x5aGY8/mfQvUWt0f/
	ULNPD+xfRGik5np0MC81WIIOggMNLBiVjaXC2D73ECx67U3tCPDWjsR7v63ANTgGl81XkE4hsI0
	0GIURoyUBLeW+kANJr/2qHAKf7mr9eLdAHQ
X-Received: by 2002:a17:90b:1cc5:b0:3a0:9640:8036 with SMTP id 98e67ed59e1d1-3a09640858dmr258738a91.6.1790185775461;
        Wed, 23 Sep 2026 10:49:35 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a081274d7fsm2065754a91.2.2026.09.23.10.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 17:49:33 +0000
Message-Id: <DLMVW6Z8IU9P.31OHF60Q6YCWP@gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: net: test untracked NA
 recovery of FAILED neighbors
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: "Ido Schimmel" <idosch@nvidia.com>
Cc: "David Ahern" <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 <netdev@vger.kernel.org>, "Arun Ajith S" <aajith@arista.com>, "Roopa
 Prabhu" <roopa@nvidia.com>, "Jaehee Park" <jhpark1013@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1790127207.git.lfqlee314@gmail.com>
 <ce40008682ed26ab039168a5fcb515eff8d30c3a.1790127207.git.lfqlee314@gmail.com> <20260923083633.GA2626135@shredder>
In-Reply-To: <20260923083633.GA2626135@shredder>

On Wed Sep 23, 2026 at 8:36 AM UTC, Ido Schimmel wrote:
> You shouldn't have added a Fixes tag. Backporting this patch to older
> kernels will make the test fail. Wait for feedback from Jakub / Paolo
> before posting v5. They might agree to strip it before applying.
>

That's my mistake, I added it in response to Sashiko review feedback on=20
v3 but thought it was just for documentation purposes, I didn't realize=20
the tag would cause it to get backported since I only submitted to=20
net-next. Sorry about that, will wait to hear from Jakub/Paolo before=20
sending any new versions.
