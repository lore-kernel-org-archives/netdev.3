Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78936682C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107501; cv=none; b=svvi+pzIKBSLjrWJ08CADSxFtTbdy2GCdn01oWr4fb2vykhcQAUKOwkxcqDiAkd3NZKn54qIiwARLGjZLVbKaT+R7qTLCqypJa8gEDxmwymIPls8KbrASB+GZEhLozQlObKFVof1ygMigiixrD/YvjvLYaKHEd+oeMTk3HJxYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107501; c=relaxed/simple;
	bh=qMKVcxH3JxZ2sUWwtxj/iC4YG2Sf3lqypstyaZYLIew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLNJD2lrAot3Lk4DxjofOxpnkml2JrmkVv8WNlNoVpRexT8/Vzp+jH9XTLHtlWUnvMsDxCf4x0jvcj44mn/+69cTG0Q3DpPT0nz/rrtAIvF2ibFE6rFsIG7SFoLNq1fPbx3DxyZMVUHYxjY+LX3RL/8KQg8kjt0T6X83guj67JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=UAxOvLyk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="UAxOvLyk"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1772107490; bh=qMKVcxH3JxZ2sUWwtxj/iC4YG2Sf3lqypstyaZYLIew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UAxOvLyksafMv4xOBZT3Ygt991y/0VBfiJ0GXPzNRzSuatbgpYuwtJV8NwH6YOaXo
	 tSPGYce3i+p97CYUNxL91cpme4NOlQhmPfz3Ch1K58j9kLWo4GKXNCNI90emm4z/nk
	 vLhhNliVEh96U2xXQlKAYa4TJFTd5JPzndf0EwlNM1hJdkrqxb6nJdqLdKJtpfeG7Y
	 p0AhEbJNX1t5djKpQjNpap5aRezlUwJCsNzpSB6LsBElo6C1bKcByYZrC4t+jFMzAN
	 kmpCNFCAD+q56R9AuX2rIeByonzUM52xHy+H/HW+uXZFUqHxJhLPLFrjzFdIuYNO46
	 IQ3AvEb9/eJsg==
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Jamal Hadi
 Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>
Subject: Re: [PATCH net 1/2] net/sched: sch_cake: avoid sync overhead when
 unlimited
In-Reply-To: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-1-01830bb4db87@tu-berlin.de>
References: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
 <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-1-01830bb4db87@tu-berlin.de>
Date: Thu, 26 Feb 2026 13:04:47 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v7fjlnhc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> Skip inter-instance sync when no rate limit is configured, as it serves
> no purpose and only adds overhead.
>
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-=
instances of cake_mq")
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
