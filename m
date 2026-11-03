Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727863;
	b=LMqIf/HQCEKqRGykNSDFhRp8NAvlbPsH+aU4pjvBNocS6HrS8aphHssXG1a+9y5uffdM
	 FdD57zp8QJVSAAjqwK8hk5Gg5jjMLcxxy3LYOB2V/ok2ACDNM+iJA/AMjh/OSkIMYB0yp
	 5N+Aees+3T2B1VHX1HpS3w0qBUEziMqCDo2JcKtd3UpklRujne40S/q+MGgCwaO6bsGed
	 ExIHHMwBWpIPXL2UBAjUbNqWuX8jXj+u8bWh9r70csu8xtqUBTOvs6LwyI3K52vQ+rqaD
	 Vew6MBiETDI9daGhXV7bKWitNhqzNYbffQgZLc+bFjrl0aeIAVcgJu/nuKXXJgTRKCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=NNObl/8/BGNVbHmQassvNIGqYnrJjK/4I853oE36ERTG5bdnp1gP/JZwd1Sqdg/LFt4D
	 Z8XFFFFHuENoU6bnC98lgtl8rHgP7pbTa+MaYIxG5O4dOuTdPR97dD2cfJxChq2qHSJa0
	 PTdvd+9VRhTuEncCvrhTLTDQBynPh3MDa0IC1SZyeHBlynnRwcaIWsP89LqHJ/fRKESBd
	 rFhOW7ar3apY/vciOILHqmRp21SL2xseI5+Y8Xx7+pYUsuhPV5VKzyYPnmAhmQSOhEjy8
	 2NVA9V2lgpggnAjg3R7Tdi7+QE/JE/tqrNNtrtlPu3C5N+1u4CBpQ/+sEPul7aKEQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4Xyjy2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540A606A324;
	Tue,  3 Nov 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4Xyjy2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96251F00A15;
	Tue,  3 Nov 2026 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793727863;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4Xyjy2bCppZyzacF2qnihNHyiduDGJ6cijTwmC7kY3e1XMp6vQXotJP/2PX6g9yi
	 IBWwvWQ5TdnS0lZ2iTX8BvYnh+BY5HZ1+CXHhL6z/Ma39i4+nQd+KsVoutN0cAVKTp
	 sH00MlRr1LdrYMQbUCPfr+DgzAqllvt2wG8XxRVxkTgO+5WpwgLq/MpBKGofsCtCBi
	 a9bc5rxCXZz/m691X67nIO9L43JYiWSPsiteq7g3PqU0GQywM7LzzF3G5IaePnKcLK
	 SJcl3xD5v0MKpRTFPb1h90vyBYavCupoVIRlyZNfa+43obcSnqlDTyzKFG/3XlJY9K
	 xpvBmlB6J4SdQ==
From: netdev-bot+sinfo@kernel.org
To: shaos <shawnq1@163.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: reset sch_plug epoch state
Date: Tue, 03 Nov 2026 17:44:22 +0000
Message-ID: <179372786223.488859.14569334200179324553@kernel.org>
In-Reply-To: <6AEA1C24.11E1A7.00008@m16.mail.163.com>
References: <6AEA1C24.11E1A7.00008@m16.mail.163.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
