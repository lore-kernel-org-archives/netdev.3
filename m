Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437E329E57
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885489; cv=none; b=Vk/bXEvXLDcToD7jb+37Ttq3UGqi+dhrlMyNqRPhU+9ypUCPFCKYFFIQsvfC/SGKrURMBamfy07OPTexbTLP9fwaQGO4lPrU/Gavaca+d5276+QA4WZ0OmRPntYrAPe4pr86WtOpLHF9OpEoS0sxqLHdcC6vIP8aAJ9ffFOwxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885489; c=relaxed/simple;
	bh=0VkjYryZowNMu1EDooetduYdfglDwYWjSvl6W7SQww4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2Cqys5sCFV92x/bnkN0OFjNBIjYaYb7AtGrWnA0IhIU0gCWZk9yqYs+lrW9rv6+7KUlBfnrWLPg0PelsnhTdM2drRXhyu8nXQznheYEVVRr17jTZn8g8e3HVtG2/jY7LLx7BzetaIAoPw4CpdfbLfYBaA0+SJDC921fHZgll6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkHMTjfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkHMTjfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69674C116C6;
	Mon, 23 Feb 2026 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885489;
	bh=0VkjYryZowNMu1EDooetduYdfglDwYWjSvl6W7SQww4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkHMTjfwi9BNWqyi7Sc5EkfgMIJwtJ04D9iNieiLLY8abJVwZleVTsCyNfiVsiUKh
	 pHS+tHR81salKY5O0tAK4xN5rdF4wR92Zeh7e8aRpdwBZ9kEuvPL8XuGu0DJAm/1jv
	 tW21L2qLq9LSXfdEneHLV1Z2Bx1Bc1doFEB3Hz661hAtD1tA5m2s5WgJF9F0X1ws34
	 Bv90GtyuzymJHbM9KNRX7xBC2Jb/r7d5thIWooUsep3AqXfUFCJU6YKyYwUlxjtHss
	 39/+KD1OvdM+U4N1MNNROT+/uaBLfGUXuYo8vaylURd7kC4uEhZZ6PYU0DOTVGK3YP
	 Q5TvcYd6ZCeIA==
Date: Mon, 23 Feb 2026 14:24:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Shantiprasad Shettar
 <shantiprasad.shettar@broadcom.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 17/62] bnxt_en: Make bnxt_resume() easier to analyze
Message-ID: <20260223142448.6f59bc7d@kernel.org>
In-Reply-To: <20260223142344.62457ab3@kernel.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
	<20260223214950.2153735-18-bvanassche@acm.org>
	<20260223142344.62457ab3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 14:23:44 -0800 Jakub Kicinski wrote:
> On Mon, 23 Feb 2026 13:49:05 -0800 Bart Van Assche wrote:
> > Pass the same argument to netdev_lock() and netdev_unlock(). This patch
> > prepares for enabling the Clang thread-safety analysis functionality. No
> > functional change intended.  
> 
> Please split out the 13(?) netdev patches to a separate series.
> If you CC us on a subset of the series out CI will not test it.
> Please keep in mind that we ask to wait at least 24h between
> resubmissions

Oh, not 13, 5, you already spammed us 3 times with this. Sigh.
