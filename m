Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAB302CD5;
	Thu,  8 Oct 2026 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437729; cv=none; b=dKbVqaZj4gf37sC3bmqJ5x6qZMmsmErw2hWDIUNMfUCE8P1aTVWL5JDgWoe1nqCUOeJ2G9dwrOcsVOjQtqCyLhCROQRCn/ehTEgNsxN43jIZbNCEKnxvMfLxr2EBZQFlZsaGOgOZhc98kJCmJgS8ZmmzT9AD0SWq1yaaZikMcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437729; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skEAXn1PShPCMDVi8uzsDoPcs21ERG3yyvODXqOlZ+cTcB8LRUPUsKNv6N+S2wVmvq04EarhNh0JqO7ZIkefc0ARu6W6n+ssLl1MV1m4C4RDvq841p87I78aKl6Rlve8yTGPCEEWwV9jVGojK2VmGbSeQb4egt1U5agVv2baTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdGgphG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdGgphG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E992E1F000FF;
	Thu,  8 Oct 2026 05:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437728;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IdGgphG655rhoUCUd7JI6pz+mwKuCtFWpi5E/e/JWfos28A1dfaONdP0azJKrwKed
	 W2pclOnLV+J/HyYQsWleQyQOANnyK/MUqcoq7u/feHdOCn5tWEY8orMfMmw7BjEiL7
	 Aw0pp8n7R5DWKVhXHylyn/Kd+Iab22ZuGgoAT1R6KTBzWieBnb+DbLrl0QeR1PacHP
	 SC591Gbqn1DkVWgYEyjWtrHxynimVzzoZ5mZzUhhP0OMVHoyG1gFVUsUIh/cM4KvGg
	 c4Ik1f1GlKHdf2UNy7wDBw/2cvMVMnV4bCUzJJXIRz/MZ1A8Uzcwg+bJrrIqk0qIc9
	 jSltAGmPiT9Ew==
From: netdev-bot+sinfo@kernel.org
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
 Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] ipv4/ipv6: do not warn on route notification
 size races
Date: Thu, 08 Oct 2026 05:35:27 +0000
Message-ID: <179143772749.2527009.14262632794282802688@kernel.org>
In-Reply-To: <cover.1791423190.git.4ncienth@gmail.com>
References: <cover.1791423190.git.4ncienth@gmail.com>
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
