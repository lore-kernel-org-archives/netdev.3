Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3636B055;
	Sat, 28 Feb 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300956; cv=none; b=fqneaGlERXiOy97ASH8CSxVAheUUr5S1q2lculd7HX51FVgIg/pj00AG7OOEJ1Z7LJHwP9AG3qchG7dhk5e89ce1atPCHWfYrT7Gsic/ZzHsd8xj/GvA7H41Mp/wwhcLos8CLPDhwIJVk26YWDYA32qiNEm1WWlWkIemWVcXWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300956; c=relaxed/simple;
	bh=usXkaTvx+omjLiyDKo53ULkvvfCWDmeq0MN+k6XLGw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADsXkbWpHgKE3vxDTdjka9kXXIfu/npkdzT8jk6rnq+rOPmlnLhgJ9fH8LV8IY0YfL1eOeIKSJkTURtYGw5b/6im7e9k2BqrmsSlEt5sYbfe+cDfFf0MB2IxVvFNAZ7Hk0OqXOLvhz1KEKvboNK01napYj/75QkoZHQX6p1oJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC3DE9uR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC3DE9uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6252BC19423;
	Sat, 28 Feb 2026 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300955;
	bh=usXkaTvx+omjLiyDKo53ULkvvfCWDmeq0MN+k6XLGw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AC3DE9uRA5Ndn7OfwraP7ZNCB7KRqiap9RapCvgNXRtyeQED+xPYLJ9qxCpNJOorQ
	 uV60a2NUV3lVYQWHeZs7SAb49mUDlYwIdtWsFrlw2AyuZvijs4DNMMDs/3EQvEkCW6
	 0FHVRsYcY9Q79xoKOzBqpr0GKPmxwbs8u0Yu6dZbbLADL2v9HtnU9uVZ/oTPV6N8rn
	 FQxwbmcuWMz/8kdXd2SpvuMR7vj5b5pEulqinGp62EyK8sjcr/u8rpYtT9+xS9TIzs
	 sRxbVDPB4sJ3uZWsb6QmVx9jRhuOAG7FNbi9BrV4hLXHHkUa8V4CYlqNIBG8SWfFfH
	 pvWird+xRlXjQ==
Date: Sat, 28 Feb 2026 09:49:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, hdanton@sina.com,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH net v3 1/1] serial: caif: hold tty->link reference in
 ldisc_open and ser_release
Message-ID: <20260228094741.1e248271@kernel.org>
In-Reply-To: <99a19d63fa322bf21463de1671085655a3f444f9.1772055898.git.shuangpeng.kernel@gmail.com>
References: <cover.1772055898.git.shuangpeng.kernel@gmail.com>
	<99a19d63fa322bf21463de1671085655a3f444f9.1772055898.git.shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 20:36:42 -0500 Shuangpeng Bai wrote:
> Fixes: 308e7e4d0a84 ("serial: caif: fix use-after-free in caif_serial ldisc_close()")

Please repost and make sure you CC everyone who has given tags to this
commit. The get_maintainers script will point them out to you.

And there's no need for a cover letter on a single patch submission,
just add the extra info under the --- marker in the patch

Also simon.horman@kernel.org is not a real address, horms@ 
-- 
pw-bot: cr
