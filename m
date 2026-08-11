Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB01A3160
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458200; cv=none; b=qEEODlF0E3GlPIUydM2ByDqsMoWySIL2pO8MoqgIlC2xU2Z/wXem0ioqQHE9CSwW9fuRY8Of/1CB+CnIl4EurId1C8FiNCMwDUBNJP+YGuuAJ85LiyWcdJuunEUDOyViqa7W8vZPv2NJ4XKpatHJTlVR7Dr6OA/NtBqIy/Q+0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458200; c=relaxed/simple;
	bh=G3CQLb9SdueQin5wBr8nwwb++DWwFwUzHq3otv/6yxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pmChLq9F7rA5TqSZTzl2lvgZdLsiySjwNvnO8mpKLxYANKG1x7A/sweI8ZsPVeisIYdH0DPDTN4v75QHZjtp2+p8jZCjndoFOEpVTeZKMUpnckSRt0jBnStIWF8/+FQa275iV9V+Z0JLy8A+bN8ipG3SizDc5Jw7bi3+rXLbs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8LpvPW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8LpvPW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF8C1F000E9;
	Tue, 11 Aug 2026 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458198;
	bh=Jbqd9yNqpaIV+hwHQdsiOiPypqoGsa/bVT+4r+E2ETk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=h8LpvPW78PFMASO4w0iKMb/OlZTEe9xPXXtkd1JxHKf7xnbW7ksH6jlvtgP7P7s7N
	 qoa05kNJxla8isQjnIKmkJ3R8vqhxSydipYOLEJi4TUaw8M08eS8gVj/aXzDpY9VLO
	 7HzSQ+oLP86Z2GK3OWPoAV+SjUd1ekXcF0tdGxi5fvSOg+IBlqP14CGBYT8gJk+7G/
	 isSAceFq+dFC+6hiEsHTkSETRdHAaanigK2cNQGWyjp0qr9UfPiMthG6GkV+d9uXgz
	 jAUzdFXJ/HcLAFP3Udk4OiBhJEY4UGwBPY9qS/gs5FbM8MXkP7XzdYgGnI9eIMiXCg
	 V1DwEtborxueQ==
Message-ID: <8c0e9e58-df43-4c4f-a3c3-3f58264ff09a@kernel.org>
Date: Tue, 11 Aug 2026 08:23:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 3/7] misc: put help to stdout and usage to
 stderr
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20260807154306.111200-1-stephen@networkplumber.org>
 <20260807154306.111200-4-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260807154306.111200-4-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/26 9:42 AM, Stephen Hemminger wrote:
> diff --git a/misc/rtacct.c b/misc/rtacct.c
> index cd84b7f0..0e2c03af 100644
> --- a/misc/rtacct.c
> +++ b/misc/rtacct.c
> @@ -412,14 +412,13 @@ static int verify_forging(int fd)
>  	return -1;
>  }
>  
> -static void usage(void) __attribute__((noreturn));
> +static void usage(bool help) __attribute__((noreturn));
>  
> -static void usage(void)
> +static void usage(bool help)
>  {
> -	fprintf(stderr,
> -"Usage: rtacct [ -h?vVzrnasd:t: ] [ ListOfRealms ]\n"
> -		);
> -	exit(-1);
> +	fprintf(help ? stdout : stderr,
> +		"Usage: rtacct [ -h?vVzrnasd:t: ] [ ListOfRealms ]\n");
> +	exit(help ? 0 : 1);
>  }
>  
>  int main(int argc, char *argv[])
> @@ -469,7 +468,7 @@ int main(int argc, char *argv[])
>  		case 'h':
>  		case '?':
>  		default:
> -			usage();
> +			usage(ch == 'h');
>  		}
>  	}
>  


rtacct.c:415:19: error: unknown type name ‘bool’
  415 | static void usage(bool help) __attribute__((noreturn));
      |                   ^~~~
rtacct.c:29:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you
forget to ‘#include <stdbool.h>’?
   28 | #include "version.h"
  +++ |+#include <stdbool.h>
   29 |
rtacct.c:417:19: error: unknown type name ‘bool’
  417 | static void usage(bool help)
      |                   ^~~~
rtacct.c:417:19: note: ‘bool’ is defined in header ‘<stdbool.h>’; did
you forget to ‘#include <stdbool.h>’?
rtacct.c: In function ‘main’:
rtacct.c:471:25: warning: implicit declaration of function ‘usage’
[-Wimplicit-function-declaration]
  471 |                         usage(ch == 'h');
      |                         ^~~~~
make[1]: *** [Makefile:25: rtacct] Error 1
make: *** [Makefile:72: all] Error 2
