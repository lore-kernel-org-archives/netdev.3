Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722583C3438
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843309; cv=none; b=DTNoXXPhCH2VvhHR0+kXJcqtih0SqY7KBVircAspn+0Pb8m+IR9BMNPo1xIG0DBpaKH+XADzuLjdaolqcIhAszRd3XBFEGYv0Zm4M8hKzpDVoMuFxGBFS4bYFFvUHUMbNWY/nJIqWoLE5sXij/fSnAv5jzn8ngsK2a7mpMhAgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843309; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxOMcHjGePFcDrWtSbMcK3wTIRS4WncQmRJn9YYshs/uqjARZjwBAgxBajABrxMbnME5XT2Qs7AMQeJksmK0e6g1ai/8tZnHi5mzoEeLm0fi7jH5Pzr++SAfXPsGDjIvb5aa2qXpbH5AQL/ryKEmxwaKEGqV+IhX3mVBI9HSOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X50ojJfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X50ojJfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4CF1F0089B;
	Mon, 12 Oct 2026 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843308;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X50ojJfYNp5Ggdz0ckYKKbv03rzqaRQT7EYWyJimaJ4711JAVFAFA8YDIQK/4lTCn
	 xdAke8gtzyLGWbjeMyCW8EI7hsQlk/GyCboS0aQ2IyC2HiF2jxd86HAEvO2I5Lq6bM
	 U9VdJFDYnWleGM5EtwxFWP7azBP7m5Kd0nuqgY1o2Ip4g/rEpx/AlRajpyKkLpSUb3
	 GDm2X6Gy4EyUxjltsZE0Tgvc/nSjnZw7W6OagcR/QhkmAQM5wgbJVkqbRxjZUX1Y+R
	 tYvfge4i6BORit615ZRmycKvQJnk+66aYbe1Vi901p/+AIgl49u/EeSdYxxQh/9GwU
	 rbdkCNcuOdm9g==
From: netdev-bot+sinfo@kernel.org
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 0/7] bnxt_en: Ring accounting fixes
Date: Mon, 12 Oct 2026 22:15:07 +0000
Message-ID: <179184330708.2527009.13518324856778830889@kernel.org>
In-Reply-To: <20261012220827.340998-1-michael.chan@broadcom.com>
References: <20261012220827.340998-1-michael.chan@broadcom.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
