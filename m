Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672595;
	b=j7UObwN459F8TJJwbJZ6GdXOmtMUFO9ZJYyvoUPpbL+i+cmCc0qhGgVFDn2i09G/9ENr
	 1vd8608q8o46r1yZAXhdfGbMFpuy+H49TZLRslo1HcNwD/8ybbveQFd+57tMUVCZs/kzo
	 QhA3EV5fbWiHHBFIF4+hTHhJSlii9hDuEZp3HkdOshqM63eHfThXo2yfsebIudwZk+GaM
	 c1U6U9cUe7EuCfuIHJC2JYXMbdNb8WYoj0fSyypbfK4e7evbpPabMjOBP6HLZnwryVCfb
	 fEBwhDBOF6T1MZIP3RmBBMQCYqDgDSoj8OoCF0YpL+K51uR2KiSxa3FHkzwy+dxq++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672595;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ob3XsAgfsJ+9EiGif9J+W/rErmfXCX5oRUvF9gj2TmQ=;
	b=l5uRtWs/JmqC9P1WbWLtpp04HmukjMHC0QtfkECrSm5AVhpFwYa8f/wHielqduk3oJoU
	 PGw9pTDdc21B4VefnBmKkPnPGlXPNUXZ5oU0vQcoeNN13GGjr4x2nVTwGN/RBGmgIho+G
	 WddGvrc58nM/FEbJdDs5ikTIXmYGvRfaQS119c9t2GT9UgNkBO0T3Kp+BSxHaGR0qsFzg
	 Nrnfu874xrMOTpOrsiOVqQRhVrfcJ3qrYyG7fsdxdW0FeQUVgUComChTNNNpwhImj7qAM
	 5rZ0zP+4Jt4gFn6QUWrPdhzPvFMMH14wqdyuXrPWYxOv8MsWZ7YoKUn3Rmwb2JbVPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=yDB5L65J;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A4606A324;
	Tue,  3 Nov 2026 02:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595A4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=yDB5L65J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=yDB5L65Jpj39JzxEqgGOsqd9XruEBKWQbCvt7VDnW3M0nV/3OGJk8gFciTa05113A1onxO7vr+Eoa
	 /Sb6f9quV6YMu7Zonmq0yYF33XdaV35yULngoaQmdYUNZadaSPq/w7v3v4a7BjKQGJNFVSKGnKgIcg
	 fbyCbl/F/mjUQayM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae9458e57b-5accd;
	Tue, 03 Nov 2026 10:23:11 +0800 (CST)
X-RM-TRANSID:2ee66ae9458e57b-5accd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ae9458e919-e695a;
	Tue, 03 Nov 2026 10:23:11 +0800 (CST)
X-RM-TRANSID:2ee56ae9458e919-e695a
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	yana06070@163.com
Subject: Re: [PATCH net] ipv4/ipv6: preserve multicast filters after a failed source leave
Date: Tue,  3 Nov 2026 10:23:00 +0800
Message-ID: <20261103022224.231647-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130658.GA922454@shredder>
References: <20261030063603.697510-1-yanxia@cmss.chinamobile.com> <20261102130658.GA922454@shredder>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ido,

Thanks, I'll drop the Fixes and stable tags and resend this to net-next.

Best regards,
Xia Yan


