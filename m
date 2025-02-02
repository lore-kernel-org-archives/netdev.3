Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04779C4
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738460852; cv=none; b=EDDDBrPu1V2LbHie/UmgUwgPqh9y11M1DABIEy8m8tdcMzRoMRlShd94Y6Zat8ecanwwZBdGnUe2Qt/8b2FCYWESPDHu06L4FOWxbUZp7c+6t65vvOJ43SlJIJikCPsu2tvkwaxk0/EYcZwccu5One6T8aKQh4l37pseTEfYAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738460852; c=relaxed/simple;
	bh=AmfrPAVMIX6RlFjLoZNU3YcZnoHjpRGrAyqTGwDRkfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDruAJGkw7af5/Yx757q1BK4lYxG0C0unuCMDZxLxnBRnSIgo242iczoKGFv+jKXRDyFB0jyLQNQ0SXsdGXPKnQ+cZlWwGkEAOSyanUuXQuLf9GD9Dst4Olohxavatg1Nz+vmpUud7dsIJKcYF5lk3FmViwb0BQqzrrJCCmsO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYe2DXwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYe2DXwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F7CC4CED3;
	Sun,  2 Feb 2025 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738460852;
	bh=AmfrPAVMIX6RlFjLoZNU3YcZnoHjpRGrAyqTGwDRkfo=;
	h=From:To:Cc:Subject:Date:From;
	b=AYe2DXwZ67WxPMnp48Fx4RK8m4ROdHpvZws30Ivod0rHW+vZjY4zvF1rGEGzuuZnd
	 P5mLyARXtE2dlISkxldbPk+oymtKS96k8/Gc/yZ0A3U089XOqcK9NbVypij2V6htDi
	 52vXlBAVf+bnRiZdvjdnYTo9+/Qf6jLpwq/EA/rejBJOD7N4VhsvhWMwweTC6bvana
	 6eA4sEhTTGGKfMAlf/fvUIwUKQIWnGLG7P7FF78HD3/bjYV3Io2oWJgTl/NPjR/yZH
	 rvvbULK07CqKCB6BjpBxOsiMwQ5lWWpHlpJkkfXXWzm0cPe3glTQ8hGyOrK0Ee3qou
	 mQeGc/QS1loZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/3] MAINTAINERS: recognize Kuniyuki Iwashima as a maintainer
Date: Sat,  1 Feb 2025 17:47:25 -0800
Message-ID: <20250202014728.1005003-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kuniyuki Iwashima has been a prolific contributor and trusted reviewer
for some core portions of the networking stack for a couple of years now.
Formalize some obvious areas of his expertise and list him as a maintainer.

Jakub Kicinski (3):
  MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
  MAINTAINERS: add a general entry for BSD sockets
  MAINTAINERS: add entry for UNIX sockets

 MAINTAINERS | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.48.1

