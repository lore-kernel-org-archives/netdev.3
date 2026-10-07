Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BF25A655;
	Wed,  7 Oct 2026 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410950; cv=none; b=eZINh6IfzVG45woa/jnjPfOSkUUmjFS52KwM43F4HhPaNDpN5opsjJ1eyv32HpVic57Gh2eTvrHAkVlZPAV0E7imHamkLNZCvQo+Lk2Gtdi9XF7ZzWP9egMWjTQmMnmU5XbsbvtnvqD+V2ZViY/aI1kI5VawYVUlSU0wFbp9wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410950; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXt9ENSSuamCWSzjhandzPoPlBidzibSkZ6GWlCZI6/79sv+cH+vh1rPlHqIhfUM1bLWD1FkrHu/QWLUh2xZwdmsyvKa08Y8+nrRCZbAfMGypR3gJwX6aivozNrbCgKn1QvLMid7WAw8rUGpxwyVXlJgnG2lgXSYGmT4kGkCABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoFKF//T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoFKF//T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168F81F00893;
	Wed,  7 Oct 2026 22:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791410949;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IoFKF//TN42I0jirtOLidfSIfc559IFmrwv1QI9xFQCG9NJlK/SaehXBmyIlPXkRy
	 2EVTyNGILKdOz9msncwgm1Ii/f/AxGd4hx2FT+0llgR+nJhCo5mfJOBIWBHBFeITjU
	 ZAiTHCdH2qXd1euZx9RhofT7NBiwPv0o9kMnJvBTi0WWf+exUWzfH25XVQoUjF9T49
	 rgeO4k7gfAoNMxIoib5qDe88Nt4aKFo4QnxAg6nUy+o7o9DLaevCKt4OssGE21leJ/
	 ++9JjmOphaf49nRksnSB0cqycBInLatkqjaq8O2LWxvnWcOGJbYjLPW9Ay2nY1Dvb1
	 ENwHiQjEZW6vg==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Wed, 07 Oct 2026 22:09:08 +0000
Message-ID: <179141094859.2527009.4935200551311639225@kernel.org>
In-Reply-To: <20261007220311.113827-1-omermetekaya0@gmail.com>
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
