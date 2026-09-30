Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156D2D7DD7;
	Wed, 30 Sep 2026 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744990; cv=none; b=KClLIFmDGcBSrUeiI2dGmXLfOC5AHLC2ioznU3B2Bk1YXljwHCla5ChxUi+RfbD9NcQfLmioCLtxZFGzSeApRa0NjhiDwoga0rCDz5m4NemcuXUSJ1BGQAxgFbZ+WO5r/sX5enHv/xF8FkxtCvmI0VGOtLYUMUQqv2W+qSa1MSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744990; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dyn7kwVBpWkzMB6S6UUI4kTAsQw/jd+Jlk/gIlVyXFd4JLUOBu1/ngaD3DWRrOuj3dFnZ0a+dXMswKkwdeQ1gNEeS2NFgKunchurLds8K8BVQ+VqvoEDlFbjIBEqaEfFLCRwaQR0XF2HvJUYa3CHoYNlVD3uvl756BS5cNC5Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azIBpBoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azIBpBoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A33E1F000FF;
	Wed, 30 Sep 2026 05:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790744989;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azIBpBocWrTtONMsDLx02x1DfKVJginlQbFpAm5N05Di5OvS5T19V2/yuEXTliHE8
	 fV4qE/oEj6fbU3pDEoQ2aG5y2WZtvSZuuWRZ3iDU85npKr3djLsWtz9HMr+Dh9bpb/
	 2vi3eom+EcQKsq86J40cC35jdpOBwt1ZL99Iv/47jRgM0BPTZeAwyc8MX2PTPTl73b
	 RfhK1wrQTr8vZtaJYY/ONZUKnrg67qlZeC4qyr7Qvr1KAR+xnrL/hAkMYv4YJDKApU
	 M/IZgzSfZhQR9VqeJLrvsnwdJtmY4CAsJ8cDamJ9O4XABjhtJ9s9yDBe0MCNCAGqSw
	 J9MIJB4luKsNA==
From: netdev-bot+sinfo@kernel.org
To: Roshan Kumar <roshaen09@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, chopps@labn.net,
 linux-kernel@vger.kernel.org, lilly@aronleigh.au, shubham@octane.security,
 gio@octane.security, robert@octane.security, paolo@octane.security
Subject: Re: [PATCH net v3 0/2] xfrm: iptfs: fix queued receive state lifetime
Date: Wed, 30 Sep 2026 05:09:47 +0000
Message-ID: <179074498764.31693.18022095890402518812@kernel.org>
In-Reply-To: <20260930050307.1978654-1-roshaen09@gmail.com>
References: <20260930050307.1978654-1-roshaen09@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
