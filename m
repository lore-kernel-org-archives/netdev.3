Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267846;
	b=u7PaC7kq6t6vbdmgiwXGocV4fEQ5PB8F5CbtFKhN5rH0wzBcnCB5om2h4XlOinvv448g
	 g/Mk8PQ1hcFkYRjia7xdn6of7LtazP1sSEFj++LvXfA+IrKXxKdkahCCuJJBO8z1vK+LW
	 wv1XEAP0bfgJrH9M8j2AEex80j2csmzBe/XN5OiINuhIa8V6u6QDZBqsZGzMaqqSA5ELi
	 1+wXx2qDwAq0OT/ob3b5v2sNJM6m+h2ktQuIAgrCdkvGw2TFGaYg28DH3dl2K3XIZJhb0
	 XRsvqPLKxTsp2jL9o9AmZSI9FvCivSehubBGtNk1H0GPIocMPEEgiPI4HkEBqVaddmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267846;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8ctZqldiRwWLyDdAy66egidvqZchsomTXo6I5wmL2bw=;
	b=tdH+dAqdVgymObqDDlKtYp1NuTRC0gugJcfyQHHYUMaUfHzjmA8vAPUGqhzImoUJcA2r
	 wEaFKeN2SvpIhPZW8ttUIcCbizeuQkv2FNXD5+E3LFPJ6KHivmx9e6uvVMc8aJ3zSZXn8
	 yIICjXYJTn/z1BbWiUDJQ4aPImwAs951GE8/4mae/k3PIW3l5K+dCygy9gm2WWTjIFkNW
	 Rmg9TdB1u5BIdURWJYmZWhm0G6YKZiTMRgP/DVoemXTnNnuK+lOp65zQkNlb7+nThRCvF
	 d3igbupO7misZnE6kdfnOULJNVfFfzU8D8v2gu73kiHxRMnELBlvsSzHTLC0HLFFSsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npr0UU9i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DE606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npr0UU9i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068A71F0089F;
	Mon,  9 Nov 2026 23:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267845;
	bh=8ctZqldiRwWLyDdAy66egidvqZchsomTXo6I5wmL2bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=npr0UU9iWs1nh7pC2QvT2ZPutLE++kMcUbFZz7HfXhcdHJga5cDr6qk7MjW7s2t+K
	 HDWS++G1oVkiUtz3Yn6tL0u3/N6tlLSehXLe8DAyIakXxZ4RBgUXYcoDhjeHrJSwaU
	 5AR42xFZVo/UUI6fzKd9At91CM3cp7K87I5yDuOV6rH2uVZYYkZ+rOYrPKC6hEaSE8
	 +xOP0Ly7hf+QZGBUvCUwkA3AG6v/BGoE3d+1rO48BNUufcX07C6LjiMmQR6FlGbIZI
	 taRqRuoneLl7nPXQV9JIGaSLwOLHqlrgmovsgMYRBynFQ7cw3lko9Anni1hasmABMF
	 8bvy1Lh7SPJyQ==
Date: Mon, 9 Nov 2026 15:44:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: add a kperf runner
Message-ID: <20261109154404.691d94ac@kernel.org>
In-Reply-To: <20261102190827.989117-4-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
	<20261102190827.989117-4-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 11:08:26 -0800 Stanislav Fomichev wrote:
> +    def _wait_exit(self, remote, timeout=60):
> +        """Wait for the sessions of a server to exit.
> +
> +        Killing the server leaves its sessions, which exit once they have
> +        released their devmem and RX steering, which the next test needs.
> +        Being forked, they run with the server's command line.  The
> +        bracket keeps pgrep from matching the shell which runs it.
> +        """
> +        host = self.env.remote if remote else None
> +        args = ["pgrep", "-f",
> +                f"[k]perf-server --pid-file {self._pid_file(remote)}"]
> +        deadline = time.monotonic() + timeout
> +        while True:
> +            pgrep = cmd(shlex.join(args) if remote else args, host=host,
> +                        fail=False)
> +            if pgrep.ret:
> +                return None
> +            if time.monotonic() > deadline:
> +                return pgrep
> +            time.sleep(0.1)

bit ugly, can we not make sure kperf --kill does the right thing?
