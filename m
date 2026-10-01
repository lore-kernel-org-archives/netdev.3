Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B251616F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862575; cv=none; b=L46bVVBvIgN0Dqh4S6+50UsTliGxqhj0QE4QFvxLyd6AlZnyy75y6KKukUUxOMNAbL7N+XdBG3XTtbshu29MM4NgRoEUqbTHgsfhEiWYMV2Z7ytkebb9XAQjZYkVMDkbrsRDP+FgRFnMVrtHJ0gv4akPiWNQ1/BWvRj2t922cMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862575; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhUOuXwRbrN+wW0i+q/VavFF7CGyt03z+iRKwfN6ohKSIioowFRmTr2UZG+L/MpeRRYgz9RzUt8SPSrBqcAMmFo1a+cJD4gyOlHR4R7FwPr752jLj5FiZac4Id8Gq27cHjfKYuX+9XeRxil6f9Sk71A6QGF0gvlP2FEJr485DsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB1sKOx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB1sKOx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7E1F000FF;
	Thu,  1 Oct 2026 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862574;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IB1sKOx/qOZlnJ1doMogGewmkKQtwbpCt7MTkD/8/xI+dCBAwsnqrqzUjzyObICU2
	 lZF/n2WAdemoxrF3SUiIc7a/Vq4uhBNeLXLCdhFFtYxYSFVdD6r9JP4JdSi2k+hcCj
	 hOcQVM4vWyAkYY4b8qNToH7j68ffApA3MThwEqX+IZCB1svgfoX1xL6CTuidXswSd7
	 4lGgV5cG/2A3C161tgddA+5Q7uNouKfvCKAnvyZRQj6FjrIt2rCte3cRzQG6cyvCC6
	 VUkMtKtivnF9r08sErUtsEJLY757pX8Iy3fpzLmvCf6BwV47Zx7rg4QtM8DIXWSdLj
	 oe9KCI1glFS/Q==
From: netdev-bot+sinfo@kernel.org
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net,
 Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: Re: [PATCH net v3] tipc: reject attaching bearer of different media
 to the same occupied device
Date: Thu, 01 Oct 2026 13:49:33 +0000
Message-ID: <179086257318.31693.2806878390189568635@kernel.org>
In-Reply-To: <20261001134432.49481-1-tung.quang.nguyen@est.tech>
References: <20261001134432.49481-1-tung.quang.nguyen@est.tech>
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
