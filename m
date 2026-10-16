Received: from mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4B399890
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118629; cv=none; b=eopgStCUQQhWbwzKao9R1uVwsg9SQSsTw7Is3UovIxcmC/K8PDjz5dXJyvFTEbGaeLO6c6z/zwBS6YI/j4si+6iVuzrMNg3n4Zwtx4xOrMi6J2EwUBjleUa3J0Q5sIotmICYfl4tCr9wlz4+IfjaHKUN5XUSHEYa2aJ7b/fRu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118629; c=relaxed/simple;
	bh=vWZ/hae/0kIcNybhhEkkPXgWxtSubbVnInKF9+ZL+lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBGq0bcZJAI8Alb2eMzFLBDh3hdAbhjL9htlleSbBCVveJv+lnTste6eMOb4LtG4gl6DKutee9K9kCI/X94n5FTNX5e1CwlFneZ/q8VGfSLpjiq3cIPY+4A8khjb4iNZLUlPtjS5kWGedX0j5iSTc4z3DJrz1Fw/9pP3FT7YPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ENgyG2EC; arc=none smtp.client-ip=91.218.175.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ENgyG2EC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vWZ/hae/0kIcNybhhEkkPXgWxtSubbVnInKF9+ZL+lk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792118626; v=1; x=1792723426;
 b=ENgyG2EC1a3j0WBHbH4zOt5Q6MIo0Dg7FWnmDWqQboELQ4r65PzjSsxr+P+L7SkuL5NZeWaj
 tUc66jtkx+R2WPlCWW3wil6rR0eNSL9lAA+NjOWpRQPngguzvJCZ6YHFZNADqdHMaFvNshz7s/X
 Vu/6ng2+O5VNFUQDHPkefVRY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id fa0e80597ab449b7;
	Fri, 16 Oct 2026 02:43:46 +0000
X-Mizu-Trace-ID: fa0e80597ab449b7
X-Migadu-Flow: FLOW_OUT
Date: Fri, 16 Oct 2026 10:43:35 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: tc-testing: use $IP in hfsc test 8c39
 setup
Message-ID: <atGPVzNYUlKY0ekD@fedora>
References: <20261014121414.2373985-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014121414.2373985-1-ivecera@redhat.com>

On Wed, Oct 14, 2026 at 02:14:12PM +0200, Ivan Vecera wrote:
> Test 8c39 brings up lo with a bare "ip" command. nsPlugin runs it as
> "$IP netns exec <ns> ip ...", and as tdc runs commands with an empty
> environment, "ip netns exec" searches only the default execvp() path
> (/bin:/usr/bin). On systems that install ip only in /sbin, like Fedora,
> the setup fails:
> 
>   # ./tdc.py -e 8c39
>   Test 8c39: HFSC classify walk still reaches leaf after lateral drift
>   -----> prepare stage *** Could not execute: "ip link set lo up"
>   -----> prepare stage *** Error message: "exec of "ip" failed: No such file or directory
> 
> Use $IP like all other tdc tests do.
> 
> Fixes: 1e24c4f2ee44 ("selftests: tc-testing: add a lateral-drift hfsc classify-walk test")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> index 4f6bbb8b57f9..557730eef055 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> @@ -181,7 +181,7 @@
>              "requires": "nsPlugin"
>          },
>          "setup": [
> -            "ip link set lo up",
> +            "$IP link set lo up",
>              "$TC qdisc add dev lo handle 1: root hfsc default 30",
>              "$TC class add dev lo parent 1: classid 1:1 hfsc rt m2 100kbit",
>              "$TC class add dev lo parent 1:1 classid 1:10 hfsc rt m2 50kbit",
> -- 
> 2.56.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
