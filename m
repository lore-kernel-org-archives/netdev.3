Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4653E2EF
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170303; cv=none; b=qJo7STlT9MDr6syX2/WGDYmfigr4z3q299uEUjibdzpymO7FydnBD+PZGJQVKpvOtJA+cf3fHHs+fhtw7KwPPX318V9FM7aGuLXENrTBgXyN4tHqgncAjw8BLYTrJDJY6HweUzI9O2xhRw5v4Lab4YJ1lrR8rhGSj7hB2CstfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170303; c=relaxed/simple;
	bh=cOmHDh/EXroWc6Eaba8PJp+ZSKKuckGFWnNzjMuWBB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5nwzVDBqsOzUe94ksd5mvsxWlBzrDACN5FYchPeQmQrqWTizK7Vmm8PTeaOzckJAViis9cYOhyUJ39m54s6D9/KbJQIIzUWtnq+GTQss/df6fnzl00zXerVecMRlDlihFNUx2e4JyGkwRims9XJUqvxLmV1uZYwrB5a3OK4PcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu5KS9yL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu5KS9yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C2B1F000C5;
	Fri, 16 Oct 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170302;
	bh=GidtaobVIZWP+1XrHFySxXxvs5o02Hdzde9c+7bCg6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lu5KS9yLhIQ8FkRkHGz2utcZ5a0ptpamL/SIem1yh/MyIN/ehLb8JEiEKzF0QjZ7G
	 uwdGIElgljPCgDr2z0Kp2MYmYcvblivIBTqSzfGw8IjlDiPP5bMX89rZlB1Vq0SzNq
	 6C1Bj3hKdRklT3mP+AMsK06nUzINwRpev+Q9qKWTiDdZop9Uh7irpo7Kx9dBJ5JfOx
	 yIGj7K3+F8QZ6L2jcsp1ZLVrB+PqKUi9clRDJRwwhmhh2Zn8v4R4YnW4CejBuBaXQg
	 Lru7cOV4mFrFT4pyg0T+7Vz1pXKjZRGQOLYjSO7iTlGT0Q9+8Tnkk5krN9jhaCWsaU
	 D7Ji95Fv2hvyw==
Date: Fri, 16 Oct 2026 10:05:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [RFC net-next v2 4/5] selftests: drv-net: add a kperf runner
Message-ID: <20261016100501.42f71961@kernel.org>
In-Reply-To: <20261005201115.2690830-5-sdf@fomichev.me>
References: <20261005201115.2690830-1-sdf@fomichev.me>
	<20261005201115.2690830-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 13:11:13 -0700 Stanislav Fomichev wrote:
> Add a helper to manage kperf servers, run the client, and optionally report
> aggregate throughput and retransmits. Use a random control port and a
> unique PID file, and report server cleanup failures.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../testing/selftests/drivers/net/README.rst  |   8 +
>  .../drivers/net/hw/lib/py/__init__.py         |   6 +-
>  .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
>  .../selftests/drivers/net/lib/py/kperf.py     | 161 ++++++++++++++++++
>  4 files changed, 176 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py
> 
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index 1b7264d40b79..4355d5113ec8 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -141,6 +141,14 @@ Arguments used to construct the communication channel.
>    for netns - name of the "remote" namespace
>    for ssh - name/address of the remote host
>  
> +kperf
> +~~~~~
> +
> +Performance tests which use kperf expect ``kperf-client`` in ``PATH`` on the
> +local host and ``kperf-server`` in ``PATH`` on both endpoints. Kperf is an
> +optional dependency; tests which require it are skipped when it is not
> +installed.

I don't think this belongs in the README.
README needs to be high signal, otherwise nobody will read.
People running perf tests will quickly figure out kperf by asking LLM


