Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882977;
	b=LKX+r0iwkrTsGIAgaoyc4Z36rDZkCpPMBfov3PbFMKpCca9fXEexAFfKcCcxNrY1i0bz
	 RGwx5lC9ILvfXF4Mpho9Morb6zO4CYpggzCCncdW3djQJVH9kZ9N/Ix2+gPIJwwVvlIYw
	 P4t4XiuLIXw/zptV+0TkrRrwqxXeDwTunHdJndsiVl5+kdxCwKDOOkEXasNjzyaSt6BOF
	 B6x8kDeKjWfzvOEQyOMfeJE5CEqE70AOI6Xn4/k5Adr8PomCOhXNJ/pd9umBwX4OVufIu
	 1Bje+7AFkMysnKCNaiYhCFuYONJp0Zi8lUvCUl2VRBCVnu/GHtOSX6RDZ5QGF2tenXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n8S5ScCzZMKTwtLSsBjbF893S2FXC4EMIPZpDHsFCCs=;
	b=3q4b4RoEOIjicjroR1ZCokvTWxmrwzspCK1fXumNzE1GvtaJsbnHOdUyfAiQ27Z0ap05
	 9vM0Frx176heU412orudifL+uOgZjsLXSkVcxOAYBQGXfjWmZ1I9eVXWrblJNbI8uLoip
	 D9+jyTcrLZ3FTXV8iaPtdNK9MduHW5cJH1G2QcXQPh1dfvP71q37PaKhfBv4R+pBd7lF0
	 8XGt2wfSfwc3XP2q+Ss1O9TlDjz3Xz7zsYmVT3GokaAsQAWW1fssdiHnYARq4Oh5qEHco
	 gAHMQsuskljI35PzLTiH/cdWxbfu/QbxIjbDdgCTHBNo2mVB1BixRL9X0GK6cJNC9fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdP5O4ti;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4202606D809
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4202606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdP5O4ti
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36dbde64409so1458455eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793882976; x=1794487776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8S5ScCzZMKTwtLSsBjbF893S2FXC4EMIPZpDHsFCCs=;
        b=wdP5O4tihaK2Jy6TtTKVgO20LnlYjG4+DN+QYUKpqF4o5ThaWx8S5x9dW2QuzqFAWc
         UrfiSF0epJZ4FEspPg44KxM3lyMbLafCKwJw9Ey4a9oohV80dncqX+8EZdwf1nqQHoUe
         uWcEqHo9bcXhPmC+lqEawurzWvIjnJZTcGZgDjU3sVs6I1PIaWV0A+zjmmLLYFay+XTo
         zEqRaFDxtzwKO28fnFSA1bM1RO8UewfYH8gITryphoUGLaGsPXVRaUh5xqBBWrYhmG1N
         uPiBnzZnjr7MbEE9NatDqYLxEe5JedRsrKNr16FOouw1Uty2calT24LzmtR49wRhJIds
         plsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882976; x=1794487776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8S5ScCzZMKTwtLSsBjbF893S2FXC4EMIPZpDHsFCCs=;
        b=ESemeeQZWCppirkEvnU2Qf7dv9ulg6JFRwJ5m6Tn/qUA2QkR0YI9NB3V2g/flE6K4I
         S+qdWDe5IjOziK2HJ02MXeht2mw2BWSIXEQbGdxTDPKaeFcd1LJXS2Hcl06nWiW8DbgL
         SDZ6UsFPK+uHCzxJP0qz/EPxwZwqaJG9TGwf3LCAFbgqrRm4HY1445x+dc/pIhzitqPA
         lHIfuuOZLbA9RZXlrgQNX0I83ib9wAbH5c9AjPJkcRzyvxZnIDx7MbZBy9GNY4uU56vt
         rUPh5YckH5eLwHlH7kTIWdWE2mk5Ft5uMMAtjYGMjRCk1mrHTUSHhwPpw4pWx+OkGkLb
         +eag==
X-Gm-Message-State: APuU4Z8vXsI3uEhkliG11ZwAWWpSnObr1sUulOL//OP4n+3Xry09gt02
	3hWFvBm6NfZ+I7C7my6tRAetfZwgoYLJlZzblM5BAJKVToGpw6aeMAI+mXJiPQ==
X-Gm-Gg: AYBFou2ZJP8Rpnuiw6VtqJ9uQPYTuV5p3ApgoKyX/iPiGC8uVyV0DIgzEhN5hNRLccl
	3aw2whsS0imuR0m5jGZVb9e3SdILnUMak3SH3eVTgBU56+PdZXLXDlKzHHQG14IxN1rbmodflAS
	tNwkfa5f64jPQEbkY8UHYDAtnEb4Y2lekZBm569eWg98u1sFHY5ru/ApYsREnpWeAE1GlbcxqF0
	oQd4sGEUETocIaXal/35FwHW35jBeFSrtGnIGp4s/3JFof+rP1/QjtoTWDFBrgB15xj+BkqRKXk
	1bDRMI21ziMOzY5GjFweK6ipWT8FmQDyGTbbrRW0L+TCTctFR7S1TGPeo0fkhW3IHHp4xD+tZbU
	ulgo4DzKKh1jQO/1L63avQlCu0oRHBpqzEk8LOz/4XdDFWFKUC+7fhbO3XqERSiK9UOm0NiPcc8
	xDrLdL3rEUaBvaRVLziB9/3AT9B5GSUS+8TT5U9R9TsIqFUU3D6NlrlAMIktATmeBF5RrNRxgYq
	lYoyA7uocFJT2KNwwoVk8Vm6pvaBOT6KrxeP9WJTO4lp43qqVNNg6Y6y2YWO1v6OESYX8vllNaD
	I95E7Sm6yepXEF3gGTCf11KdCtMTcJ9Ns8AxhyHfKDhgtHr/v6gieXuIpxJnxpSPHosm+kotkGd
	m3QUvXPK1D74Y14XczzXXxUayeRJm0L+6WPmz25GVb96fb1JgaHWtw6/G2zb/9RpoBJc28rPGNw
	==
X-Received: by 2002:a05:7301:6194:10b0:369:f937:9a7a with SMTP id 5a478bee46e88-36a42437876mr29038541eec.34.1793882975233;
        Thu, 05 Nov 2026 04:49:35 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm17708130eec.13.2026.11.05.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:49:34 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <martineau@kernel.org>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: Re: [PATCH net v5 1/2] genetlink: Reject joining multicast groups no family owns
Date: Thu,  5 Nov 2026 12:49:27 +0000
Message-Id: <20261105124927.336300-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <179387152067.488856.5027284112549941042@kernel.org>
References: <179387152067.488856.5027284112549941042@kernel.org>
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

> The commit message says:
>
>     Nothing is ever sent to such a group, so joining it has no use.
>
> Does this hold for the group IDs that genetlink assigns as fixed values?

No, that sentence is too broad. An early join does get the messages once
a family registers. That is the problem this patch fixes.

> Is this regression intended for privileged callers? I couldn't find
> existing userspace that does this; dropwatch appears to resolve the
> family first.

Yes. Before the family registers there are no group flags to check, so
the patch rejects every caller. I don't know of a program that joins
early either. A program that resolves the family first still joins.

> The commit message mentions the getsockname() change and the setsockopt()
> -ENOENT. Could it also say that early subscription to fixed IDs stops
> working for privileged callers, and that NETLINK_LIST_MEMBERSHIPS output
> changes as well?

I can add both, and a comment on the -ENOENT meaning on the bind member,
if a new version is needed. I won't send one only for this unless
someone asks.

Anil
