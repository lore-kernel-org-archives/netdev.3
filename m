Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3352D8DDB
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330048; cv=none; b=mjKopfkGKb3v1K4cWMBtRDuQcNfZg50kVCz7DQznBLNRMpuNPDcZfzEwZme0guenJrguBOG1rRSL4udLsCKIQhVYcQJIgZsiY46kp7PqSNK2yJcRZSZk8gcv7cfPLaMMZg0T9WkA8QDcUb6+eKhJBIbaOMhP38MxD7H9cyEDDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330048; c=relaxed/simple;
	bh=JgUqgmZu3vKcXz5qJfNqkgHMPjRsLhPReRKxJDDy+cs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZQ1WD4agThm8AwGp1I4ecWgmiFfkfiStVuDfRVIkLsDImdVWKM/uNT2s6rCllCstx9qwFsA57iR1ckcdoh1oR87CPk1xEqzH60EP0SeZQZ9u/RYrOMaZvA7HVR6cJBxN3SQYd2BN8gLf0h3LDxwTiJMf/qLfxiiBxpjpKMZRxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtTdD6as; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtTdD6as"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AB7C19425
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330047;
	bh=JgUqgmZu3vKcXz5qJfNqkgHMPjRsLhPReRKxJDDy+cs=;
	h=Date:From:To:Subject:From;
	b=NtTdD6asDT3Hs3k0e2i0WkvK0PB9CcUhF8vKQRw48FQaDuazeRobjwJojsTAvUhl1
	 qHyG4lHmzmHeT873CFL8Cg6k034AzQEvcU1KrA7pPLmxGTQ3oHINq1eTm43rPV5dNq
	 c40bQ7EREgxyjWKke6omdM3WfpZmo6ZNcgNGcNNCaFImOKcMmbbI+HHzAgVRKSRQoV
	 c/0+0KT3VTeK02xOZyXntK40fFy9aU2ZHu9inYcBz8nN7hOdxiIsE3tgLUkXRd9Wyk
	 951icgJ4Etk05LJP+gtnsA7ulGZdojvQx/iUAMy/selhaDG6VSdbq5BlySRLkR/4T/
	 zr8b5By7sKbKg==
Date: Mon, 27 Apr 2026 15:47:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260427154726.30b9d333@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open, and accepting v7.2 patches.

I was hoping to get a single clean run out of the CI before
the announcement but it's still a bit wonky. So let's open
net-next and I'll try to somehow mend it as we go.
