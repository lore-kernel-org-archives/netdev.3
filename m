Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B253D6470;
	Fri,  3 Jul 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084684; cv=none; b=GePoaYAmdtZmVFzwG0CrEYyuPkZ4iNsn81qNkpw3epo9kGQeQaFcQA1KqE2zM4trYh5qytmVSyN/1RnSBDj78T2s2dYaoWUo0FUPXFkkPIkNwajPMGOPpkE/6CCQ5aiJRMTKEl3mH8aufhIM9q1kl3Ex96OgLHXVrr8dGqRWoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084684; c=relaxed/simple;
	bh=6W21t04zsig41ZGK4yP5vmdeiSeuqMAWNJ/8tz/1jF0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dhLMZoz+En60f0HXizAjQkuUa868XHE86QsTzbpEpODphELsFxJUMr8yXiBOZ54e2LRVJUr9EM1BfRtRf5xFlO7qtn1u94R7UHZ1XOr4Lsjkpn+OUcO0yBeTQaXAyKM63BrBAMlRHAfFz9nrT5sFb/Q2kBwBV/K9UjBfd3az+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSxTZz2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSxTZz2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29CB1F000E9;
	Fri,  3 Jul 2026 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084682;
	bh=4uzDfoTwkfdbFHkCUQ1tshn8zcfMCx855BQAs0GpqXw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=eSxTZz2tETgzCCPZR7nAkwKRL3WdbxS1Eij5f/SQeD1puzmaMpa3AnxcSk+PkMYSc
	 va31yRhgj6fo3vhhqiIoj8byX+cG7nSsgWDTqZieRE2+TvpLCnGbpHDvs8dVoVr8lk
	 7wQ3vTr7ZlYVH4REPgeq2g3N9VobPBdH2M7CfhjPijyWodk50oXrym2JnfUvmO+9sy
	 tQQNkPKqwLdKV6xNtJ0hTQ0wLCEf/7ksAcBmlFtGtv0zD51aBVANaIXOyetLqMl8jW
	 pIxLek2mvLOPkbw8EZ3nVnG9QU6RAmcpzAOX1gGUmtM6D+dAbB3Sy/r3s1prrnMLoW
	 0JGfsRGVdH/0A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v2 3/3] af_unix: Clean up error handling in
 unix_listen()
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 John Ericson <mail@johnericson.me>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
 <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
Date: Fri, 03 Jul 2026 15:17:46 +0200
Message-Id: <20260703-nachzahlen-plagt-tierwelt-38485ce22091@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=516; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6W21t04zsig41ZGK4yP5vmdeiSeuqMAWNJ/8tz/1jF0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5b2uI1vNsTb7z4bwQ59udnq9jTD4+33P6z7nDugw5Y
 jNmMUeKdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk2TlGhv/1KQq/jpm1dRzl
 V/iqvY3vztkTk8O1jcXmr929x/f9xLOMDLNeP9yiF2vwekWUuo39Rj6NZeL1mU/X1/WKpfdzbT2
 xnh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> To avoid the sort of bug that was just fixed going forward, switch to a
> style where `err = -E...;` instead happens right before the `goto`.
> (`err = other_function(...);` is not changed.) Then there is no
> spooky-action-at-a-distance between the `err` initialization and the
> `goto`, something which is easier to slip by code review.
> 
> Signed-off-by: John Ericson <mail@johnericson.me>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
