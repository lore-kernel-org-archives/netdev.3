Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F3371CF4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833110; cv=none; b=j2PNBOoTJq/rQg27J3w+MSBoFiP1K4MAM3wBaT7URffsNZy7FXu+Mu7E1/SwV/wWeV3E14LVuM6zZJJxqNZS3Z9ZPjyJuBLD2avaWsmaIMfunZdHMw69w/Iya6OWFGKWsFEITUY3eTS167TZKVBJbSFKrMS6ZJZAu4IC03iQZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833110; c=relaxed/simple;
	bh=/Xr3mJY2YX9Pv8+HY63KWc65qLJGHcEpnZbGJQu5Nws=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=uX5YuAyfjTzNDbaFJVQo97DWo1ZFGGq4kYD1MMlxsfYhuJT8QHHGXEQHU/+8Ekv+3rCk+89wzV71H0sElCza/NsifLxmCL4rOSZD4wgME6y50t/T8ZHAJThfrAJUcSVxlx0C6vBMIT1S9vIl15Z/J5Uj38eIr4HwOuge/2Lvva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6u4nN9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6u4nN9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4AF1F000E9
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782833108;
	bh=VFqtrGwvT83GQsSUwVKl1j3l2jtS4zEWULwdCTKY038=;
	h=Date:From:To:Subject;
	b=W6u4nN9zPKhVBgfyINFsm3iWEhh/nu3HfEvhyfC2PUQT/yPywyWsqIK2/8f2lM4ID
	 8d0f2UbnIiAlsP7+ZmlYf44NhcAN5IXZp6qemSHsDQSMOeOSXu/TnPP8EMsujvmKB5
	 3e+xxTJ3iwBVMZuUnANmznHtqDJZpYAn+7sVWdsF3W7WJxbDwriMoK/GNLT0gbdAFi
	 DTh9iX3yl8G/5vs+8I29LFJxgkAySpDjtTaoSoJsjZD+Z4JTuzXP5fknCZ7IPqRE56
	 nB2WFp8FBym///PhDmazICKj2NWr4CFugcnlYrMbrnG0KJvQFbFQnjRzC5zaJoNKOq
	 scgkf8BlyVdgw==
Date: Tue, 30 Jun 2026 08:25:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Jun 30th
Message-ID: <20260630082507.6109b0ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Present: Eric, Jakub, Johannes, Kuniyuki, Simon, Willem, Paolo

Academic Research program
  - Revised with:
    - Limit of USD 50k/grant
    - Simon as email contact (happy for an alias to be created instead)
  - Contacted board for funding approval, expect them to meet in
    coming weeks to discuss 

Netconf: 
 - on the first day of Netdev 0x1A. 13th July
 - Have room for ~20 people
 - Finalizing invites today / tomorrow
 - Driver upstreaming challenges, some drivers reaching v50
   - May be more suitable for a broader discussion / driver BoF?
 - Foundation sponsorship for a meal
   - Double check what netdev.conf has planned

Logo
 - Some delay in paperwork due to the complexity of it
 - Now aiming for LPC rather than Netdev
 - Comments on the draft sheet
   - Mesh in the background would be good to represent networking
   - Yes on tux, otherwise the logs are generic, but need a distinct one
   - A voting sheeting to grade the suggestions to be circulated

Wireless CI running on netdev foundation infra
