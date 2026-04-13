Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1483B7770
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074858; cv=none; b=oEpeG57yPJTjrCr+TzcTlK+dnGFpb4Vr3StH/+pMjymIzffOAhhIv4nPdPCVzLmgfQqPgRSRxbKkD2oy65rPXCzQBRiuRYoEvqDNH5LiWWwv1kMfQuAjWW9uqazS8Jtl8lyL9kA8VhnStQfxqL+d82JftkQuBLerpphKKnaFGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074858; c=relaxed/simple;
	bh=jqlmsgW1ZXF9UwTaqAX0MQN18po3bOo3czPFfe39k1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eWbo9qyeVwFFaY1DuuSJ33vD5WrvaVi/aV+uToAp3ONOkNf6Y6RvYGHbz2y49YYgI7XjUKejv7kZrLmQBu1mIgXMUpqDdZa8ANI9u0QeG3Nke18RnJsuu7lwbVs5s1+3Tv+6VxO08tf7c2cPwME/TMFlum/udjD1BUKAiq51QV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: phx <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_cake: fix NAT destination port not being
 updated in cake_update_flowkeys
In-Reply-To: <CAKvCo-yFnu3RBbiGkaVi-X5qX_hN1a-FYrBZfzB9UKz8k-PZtQ@mail.gmail.com>
References: <20260413084715.70169-1-phx0fer@gmail.com>
 <874ilfdwoe.fsf@toke.dk>
 <CAKvCo-yFnu3RBbiGkaVi-X5qX_hN1a-FYrBZfzB9UKz8k-PZtQ@mail.gmail.com>
Date: Mon, 13 Apr 2026 12:07:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y0ircgwp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phx <phx0fer@gmail.com> writes:

> You're right, "vulnerability" is too strong - it's a correctness
> bug, not a security issue. Thanks for picking it up.

Cool. Could you please re-send with an updated commit message? Thanks!

-Toke

pw-bot: cr
