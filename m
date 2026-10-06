Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A403E7BD5;
	Tue,  6 Oct 2026 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287976; cv=none; b=D7qCd0c8JR8/wUe6z6E+xLv91gHQUJmFc0+sjSNgKqYSmJ8BG0ARTBztEsbvaTyXu3pUx777grmdLwxOHFATAzZPhLqpxw0ps4MexjrhmbCjhMdzztLTLaZ5r+Ch3zgmQvE9SY1fQ1FMJ78fJlXsx6SDyEvBll0JaVqH0XBKzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287976; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKi5zobn1sxpXz9vTDu4c6VGxRqA42y7MzJfCGQAF0NjQn2+OgAtCvbBY2prNL5tXe+gad8SszyAn3AcwmwY1PYe12vL0glqPhysM/4cgMFdba1JNzN5wdk3DxOEC4xFMVheWEf9GveDnT5gzULjdmubaevHwt1FBwBCSkpkADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4vlfnZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4vlfnZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E843B1F000FF;
	Tue,  6 Oct 2026 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791287974;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4vlfnZyGMHW0pCQ4xdEETp7dyyPI6nSGibDVYRpoYLZHjok0Ccjwe5PMFLKdQmia
	 SuOH1WdfEO5z0tJ2hyWZH/6kWR4QqBk8UCf+g3c6QRCXnZXsFdZmyvtsmi0xV5dDYp
	 Cpxw5EvYB4JpYCL8eZe5dQkbt5YbUT5UzNfb1TmGLhvrHleE3oz1ZkqDauSyRO+La4
	 i3I5+EiTUVNxMLtI9ceUtzhBTtYsdHksxkV9xNpKi+XJuDDqQf5cgc56FJVMrmwAdq
	 EMrlj3GjItsJ51CBOacQVGJxGiJsdzzQqqbSzNxL9hrwLI3/ZSebZudRMIcFXLiavO
	 7GVVFcLKSgn9Q==
From: netdev-bot+sinfo@kernel.org
To: Shubham Antil <shubham@octane.security>
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
 David Heidelberg <david@ixit.cz>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 Giovanni Vignone <gio@octane.security>
Subject: Re: [PATCH v4 0/2] nfc: nci: uart: fix write_work teardown UAF (+
 nfcmrvl drv_data)
Date: Tue, 06 Oct 2026 11:59:33 +0000
Message-ID: <179128797346.2231598.1967171829809162866@kernel.org>
In-Reply-To: <20261006115532.72100-1-shubham@octane.security>
References: <20261006115532.72100-1-shubham@octane.security>
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
