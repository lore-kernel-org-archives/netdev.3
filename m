Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E2220F49
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124324; cv=none; b=rcYNCjR6otbPr0rtSPHAjtsBjAL+Gi6iN02zPUq7VIWA+fPBr8A4sp4OzSZ9XcIzgq9AbmChPzqaiZowMRe3VcrqE3nkGsGLVFoDb1Rrb6KzNP0eXyhDhwTiTxesujskIMqJ7t55w4JC035zcoUU2fV7cd7oGa8hOm7Vt8AcsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124324; c=relaxed/simple;
	bh=pq1K1O7TccNQxJnQ8Nso91YxjW0N8Vf4GxnYClXp/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgfZF4OF23WtY3ZmOe/RO8gvrHJHZguiEJjU8AxMjdXJ6HLtD17qmgPxxin45iaTMOThABNmyQo7tFCQAXMhRWEmih7noAAechSpbc+4Ndbz28zw2xsz4gwbJbHFZj10tYEvLwef5TBuoLn1+LtjSH3LygnxBxRm7ucHJrU/Mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWwpze/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWwpze/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422941F000E9;
	Mon, 22 Jun 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782124323;
	bh=o0SRWiMpacshWYzq/KKBsYhYEY49vcEVFbcZ2GI1sYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kWwpze/XQWnhKBgMzO30Cwh22U7ewEbMpxb4AVnZ08kAi7Mbd2Eejj2djeHy/SZDz
	 8e3Jx0LVe2I5FReK3yo/0EA/MaxI1x4Mm/SiHlWqPiNFnbyVi2j1a0/JrTJ1uVm5oX
	 U+OGS3qR3HNG7gkMsDUF8sgVo38Ze2UtkMtH9cRePOFvG9IANG5B45MutPBVv21y9i
	 QulAc6HOwsYGJ0b07bkM6xXv95pChrdMJOEVwMo2U6AClMwLUPp3R9e2Ik/IxO7NKp
	 rARel/pFfyjKn01DtiG6PdA32BqCa1RiBliQkob65qm2SjoH90h3H2q6GRT85+CskC
	 SK4uNfbAdk2/Q==
Date: Mon, 22 Jun 2026 11:31:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v6 0/4] Fix i40e/ice/iavf VF bonding after netdev
 lock changes
Message-ID: <20260622103159.GZ827683@horms.kernel.org>
References: <20260619061321.8554-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619061321.8554-1-jtornosm@redhat.com>

On Fri, Jun 19, 2026 at 08:13:15AM +0200, Jose Ignacio Tornos Martinez wrote:
> This series fixes VF bonding failures introduced by commit ad7c7b2172c3
> ("net: hold netdev instance lock during sysfs operations").

...

Hi Jose,

Unfortunately the Netdev CI was unable to apply this series cleanly against net.
Would you be able to rebase and repost?

-- 
pw-bot: changes-requested


