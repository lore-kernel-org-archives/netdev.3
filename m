Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4947C118;
	Fri, 16 Oct 2026 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155199; cv=none; b=nvnXOGt+OeZaW/gFxo8FPMnBfLwn/g2sbpG0Q8RkodnfBjY7cIw0uKu5k0L7QlmLw/WVHblBLovmIO+m6vqgJ9bzJCy7FY1GnVq2BZTOc33KGOApmRDtYcMfRNWaYhKXsiqCXE4ziSxy1v4azBziWyn0/ELo0/fdWZj5NJ6j07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155199; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHgBuTYSNQzMNCOHEbOpMnWY4fvG/05Gl6L04mQYUnLh1aRhIf9o1PQfHXyL4ZmBpZZhebd0RFmlPCZ8iRh+KHer9q1XgaPlzC5wMp0Uh+AdVaR+jBxjt4RLKW3nyjTZeAFsQIIrNJsxQB6F59EeW5bjmHqL/slxIyKpAGltjCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtX0/ZFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtX0/ZFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D011F000C4;
	Fri, 16 Oct 2026 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792155198;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtX0/ZFuxsGYPTz1M4mU30tIpKUdjEejHx85+NktBpAD0NTzXc0bjZXQ/khQj7PXL
	 R1QJxphhIC68Kc6q7MVIEmFbCbKXltlcGddagqtu63P4OioNn/R1Xu4uHfytDpRXkK
	 6PMupEyp5dXsa3tRMhYwF/ws8YHx7GqpBrSMeaxSasILG0FLnkRDskzDfOnupRQ3i1
	 mmdN6vD/llj6E7UloLccp/cuwdHqRD1+cfG4TmngK7GSy58wsGKp3yiAPf43WrJSbm
	 gumid34MlGW8Ug9DcaJj9fYDxR0HonBFOR2holBotAo/daH3BRljgOGlXRhnWMyiV0
	 ZsaMHL9RdQvHg==
From: netdev-bot+sinfo@kernel.org
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com,
 kuba@kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2] net: usb: aqc111: fix set_mac_address return value
Date: Fri, 16 Oct 2026 12:53:17 +0000
Message-ID: <179215519735.408196.139629932849333374@kernel.org>
In-Reply-To: <20261016124858.1939743-1-hanson.wang@ugreen.com>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
 <20261016124858.1939743-1-hanson.wang@ugreen.com>
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
