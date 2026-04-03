Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A027081A;
	Fri,  3 Apr 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249392; cv=none; b=qKhY1LkJwT0t7psJaUjUd1pQLY7m7JBgF8LykS47wks/PRrNeb8tkIIdO5Z0fad7qxDgLkMvsZcuB/irblhgVqa0SDDaG9BEAWnedD4Ooeo2IMXilueoiTFwsSFSm57dCJH0/bMpvxUVnI8eVzg2U6UUmuJrHbaPa+iopGkfn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249392; c=relaxed/simple;
	bh=sMnhRk4H7vsQFKJHv1FLVHxi/sSwbRHHpcNnnYwCO84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jY3s6zi5MGxoMbZ/057NDOqaq1ejPS8VlMyS/e1Sw4DCc7NEnVnHzKCqviaiGlZZQ5QkZO9dNu5O33KGWGrBkKgxAhJdnqxwxoFUfH04JC1P1iB6CYb42a1QDTlTJrhHw7yDG+K7XbWQlqc/VgnHLCCZFRliOMFUF/T3dnhSU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtTvGZNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtTvGZNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5B0C4CEF7;
	Fri,  3 Apr 2026 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775249391;
	bh=sMnhRk4H7vsQFKJHv1FLVHxi/sSwbRHHpcNnnYwCO84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DtTvGZNLaaVcGJ7CqYXJdkcLABrxmaouQKpPQ7NvFPJm3ClWqz2fv+4C5VmW45wKk
	 o48p+PWxpBuuwrvAGk/xIb//Ecztd6FXj767haIoAzIUXxQ1VAFpZaPVKIdzoHBh0r
	 6HEc0P0qBJxx3hO4Wi8S8GsvVFZZtAZMhL8307OHFnZZ6ro/5+ABtZiJer6Dew5Si/
	 n4IGzeK0Ym3HCm26fgntGYCVHxLhhnOYHLzuA77T+R+KbQZca05KFhn5c6R2+nw/lA
	 A+a1WxbI9IilwIzkYvEqzV7QE2wYEOZnJkYInHLWU9XTj8ZhMEBhc27KNDMmorW0D6
	 pJaEY30em6g+A==
Date: Fri, 3 Apr 2026 13:49:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, riel@surriel.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-ID: <20260403134950.3af8b4f5@kernel.org>
In-Reply-To: <20260402232511.17246-1-jp.kobryn@linux.dev>
References: <20260402232511.17246-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 16:25:11 -0700 JP Kobryn (Meta) wrote:
> When kswapd reclaims at high order due to fragmentation, vmpressure() can
> report poor reclaim efficiency even though the system has plenty of free
> memory. This is because kswapd scans many pages but finds little to reclaim
> - the pages are actively in use and don't need to be freed. The resulting
> scan:reclaim ratio triggers socket pressure, throttling TCP throughput
> unnecessarily.

Acked-by: Jakub Kicinski <kuba@kernel.org>

FWIW
